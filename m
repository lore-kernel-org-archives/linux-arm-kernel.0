From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 18 Jun 2015 10:12:20 +0200
Subject: Linkstation Mini and __machine_arch_type problem, not booting
 since 3.8
In-Reply-To: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
Message-ID: <55827D64.1090307@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,



On 15/06/2015 15:51, Benjamin Cama wrote:
> Hi everyone,
> 
> First, I am new here (and not subscribed, so Cc me please). I hope I am
> on the right list [edit: resent to the correct one, again].
> 
> I usually run old kernels (3.2) on my Linkstation Mini
> (CONFIG_MACH_LINKSTATION_MINI, Marvell Orion based, non-DT) but I 
> wanted
> to try a newer one and found that after 3.7, it didn't boot anymore at
> all: no message at all displayed, not even with earlyprintk. I bisected
> the faulty commit down to b8b499c86be58cb309964fcab5b62ac4a240a878 
> ?ARM:
> 7602/1: Pass real "__machine_arch_type" variable to 
> setup_machine_tags()
> procedure? which looks like a quite broad change, and makes me 1) not
> really understand what it does 2) astonished not to see someone else
> affected (judging by the time since it doesn't work). Using the version
> prior to this commit works, but trying to revert it on some newer
> version (4.1-rc7) also fails, so the change must be something deeper
> that I can handle. Note that when I disable CONFIG_CPU_FEROCEON_OLD_ID
> (it is such an old Feroceon), it still correctly displays at boot
> ?Error: unrecognized/unsupported processor variant (0x41069260).?, so
> the machine ID is somewhat read correctly.
> 
> Also, my intent at first was to try converting this machine to DT, so 
> maybe
> the solution to my problem would simply be to try converting it and see
> if it fixes the problem?

Indeed it is your best option given the problem you exposed later in this
thread. Our plan in mid-term is to completely remove the non-DT support.
So converting the board is definitely the right thing to do.

The conversation should not be too hard to achieve, you will have mainly to
write a dts, build a dtb an append it to your kernel.
You can have a look on waht was done for the LaCie d2 Network platform, see
94b0bd366e36379c994bdaa84f 'ARM: orion5x: convert d2net to Device Tree'


If you have any trouble or question during the conversion we will help you.


Thanks,

Gregory



> 
> Thanks for any thought on this problem,
> --
> benjamin
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
