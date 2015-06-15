From: benoar@dolka.fr (Benjamin Cama)
Date: Mon, 15 Jun 2015 15:51:24 +0200
Subject: Linkstation Mini and =?UTF-8?Q?=5F=5Fmachine=5Farch=5Ftype=20prob?=
 =?UTF-8?Q?lem=2C=20not=20booting=20since=20=33=2E=38?=
Message-ID: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

First, I am new here (and not subscribed, so Cc me please). I hope I am
on the right list [edit: resent to the correct one, again].

I usually run old kernels (3.2) on my Linkstation Mini
(CONFIG_MACH_LINKSTATION_MINI, Marvell Orion based, non-DT) but I 
wanted
to try a newer one and found that after 3.7, it didn't boot anymore at
all: no message at all displayed, not even with earlyprintk. I bisected
the faulty commit down to b8b499c86be58cb309964fcab5b62ac4a240a878 
?ARM:
7602/1: Pass real "__machine_arch_type" variable to 
setup_machine_tags()
procedure? which looks like a quite broad change, and makes me 1) not
really understand what it does 2) astonished not to see someone else
affected (judging by the time since it doesn't work). Using the version
prior to this commit works, but trying to revert it on some newer
version (4.1-rc7) also fails, so the change must be something deeper
that I can handle. Note that when I disable CONFIG_CPU_FEROCEON_OLD_ID
(it is such an old Feroceon), it still correctly displays at boot
?Error: unrecognized/unsupported processor variant (0x41069260).?, so
the machine ID is somewhat read correctly.

Also, my intent at first was to try converting this machine to DT, so 
maybe
the solution to my problem would simply be to try converting it and see
if it fixes the problem?

Thanks for any thought on this problem,
--
benjamin
