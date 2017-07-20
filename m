From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 20 Jul 2017 08:57:14 +0200
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled
 with gcc7
In-Reply-To: <CAAQYJAvR2_wqf2Axe4aVMOu08t7w5tNEjK0s3fw_oemtqCRo7g@mail.gmail.com>
 (Andrea Adami's message of "Wed, 19 Jul 2017 15:13:29 +0200")
References: <CAAQYJAvR2_wqf2Axe4aVMOu08t7w5tNEjK0s3fw_oemtqCRo7g@mail.gmail.com>
Message-ID: <87a83zsiid.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrea Adami <andrea.adami@gmail.com> writes:

> Hello,

Hi Andrea,

I have the same report on userspace side on buildroot from Petr [1], which
triggers endless segfaults in userspace (init) with gcc7 while everything is
fine with gcc6. I have confirmation on my test farm the problem happens as well.

Since debugging in userspace is far easier, I would suggest attacking the debug
with Petr on userspace side, and once sorted out, come back to kernel side.

Cheers.

--
Robert

[1] Mail from Petr
From: Petr Cvek <petrcvekcz@gmail.com>
Subject: cross-gcc
To: robert.jarzmik at free.fr
Date: Wed, 12 Jul 2017 02:37:35 +0200 (1 week, 1 day, 6 hours ago)
Message-ID: <ea45c82f-35a8-a908-d199-c72c0c801340@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.2.1

Hi,

do you still have a PXA27x board? I'm trying to build a rootfs with a new GCC
(7.1 from crosstool-ng snapshot a few days ago, buildroot same way) and it keeps
segfaulting (busybox, sshd, udevd, Xorg). Do you have the same problem? (seems
it does not care for xscale/iwmmxt neither O1/O2/Os, maybe on O0).

The GCC 6.x was fine and if i will need to make a bug report I think I will need
confirmation.
