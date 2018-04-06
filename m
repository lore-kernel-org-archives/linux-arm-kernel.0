From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Apr 2018 11:25:19 +0100
Subject: [BUG] Fix drivers/memory O= build
Message-ID: <20180406102519.GN16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a kernel with split object directories, the following
failure occurs:

.../drivers/memory/emif-asm-offsets.c:1:0: fatal error: can't open drivers/memory/emif-asm-offsets.s for writing: No such file or directory
compilation terminated.
drivers/memory/Makefile.asm-offsets:2: recipe for target 'drivers/memory/emif-asm-offsets.s' failed
make[2]: *** [drivers/memory/emif-asm-offsets.s] Error 1
.../Makefile:1060: recipe for target 'arch/arm/mach-omap2' failed
make[1]: *** [arch/arm/mach-omap2] Error 2

This prevents any kernel being built that includes decending into
arch/arm/mach-omap2 with split object directories.

This is a regression.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
