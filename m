From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Jul 2018 05:29:53 -0700
Subject: [GIT PULL] two omap fixes for v4.18-rc cycle
Message-ID: <pull-1531484945-795802@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 0144eb204cdcdf09a76794b4a294291388e739bc:

  ARM: dts: omap3: Fix am3517 mdio and emac clock references (2018-07-03 00:39:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/fixes-rc4-signed

for you to fetch changes up to 923847413f7316b5ced3491769b3fefa6c56a79a:

  ARM: dts: am3517.dtsi:  Disable reference to OMAP3 OTG controller (2018-07-12 06:57:05 -0700)

----------------------------------------------------------------
Two omap fixes for v4.18-rc cycle

Turns out the recent patches for ARM branch predictor hardening are
not working on omap5 and dra7 as planned because the secondary CPU
is parked to the bootrom code. We can't configure it in the bootloader.
So we must enable invalidates of BTB for omap5 and dra7 secondary
core in the kernel.

And there's a fix for reserved register access for am3517. The
usb otg module on am3517 is not the same as for other omap3.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: am3517.dtsi:  Disable reference to OMAP3 OTG controller

Nishanth Menon (1):
      ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of BTB) for secondary cores

 arch/arm/boot/dts/am3517.dtsi  |  5 +++++
 arch/arm/mach-omap2/omap-smp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
