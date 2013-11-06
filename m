From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 6 Nov 2013 16:00:15 +0100
Subject: omap2plus_defconfig build failure in v3.12
Message-ID: <20131106150015.GA20674@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

I am suspecting 6abdd491 "ARM: mm: use inner-shareable barriers for
TLB and user cache operations" or the commits just before as the cause
of the following build failure using the omap2plus_defconfig with
kernel v3.12.

  AS      arch/arm/mm/cache-v7.o
/home/richard/git/linux/arch/arm/mm/cache-v7.S: Assembler messages:
/home/richard/git/linux/arch/arm/mm/cache-v7.S:285: Error: garbage following instruction -- `dsb ishst'
/home/richard/git/linux/arch/arm/mm/cache-v7.S:297: Error: garbage following instruction -- `dsb ishst'
make[2]: *** [arch/arm/mm/cache-v7.o] Error 1
make[1]: *** [arch/arm/mm] Error 2
make: *** [sub-make] Error 2

Your commit 6abdd491 also doesn't build, but v3.11-rc4, just a few
commits preceeding, does build. I am using:

{CROSS_COMPILE}gcc --version
arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2009q1-203) 4.3.3

Is my toolchain too old, or what is going on here?

Thanks,
Richard
