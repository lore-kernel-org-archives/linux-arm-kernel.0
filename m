From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 May 2013 09:49:06 +0100
Subject: omap3430 fails to boot
Message-ID: <20130509084906.GL21614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've not looked into the reason why yet, so this is a heads-up.  I
notice this morning that the LDP3430 failed to boot last night,
whereas it worked the previous night.  However, SDP4430 looks fine.

Nothing obvious in the diffstat between the two... but then the patch
between the two kernels is almost 1.5MB.  The arch/arm changes are
quite small though:

 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/Makefile                         |    4 +-
 arch/arm/boot/dts/xenvm-4.2.dts                    |   13 +
 arch/arm/include/asm/xen/hypercall.h               |    1 +
 arch/arm/mach-msm/last_radio_log.c                 |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c             |    2 +-
 arch/arm/mach-omap2/timer.c                        |    4 +
 arch/arm/mach-vexpress/v2m.c                       |    1 -
 arch/arm/mach-virt/virt.c                          |    1 +
