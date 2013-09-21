From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 21 Sep 2013 16:45:39 +0300
Subject: [PATCH 0/3] ARM: OMAP: convert N950/N9 to DT
Message-ID: <1379771142-29087-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This adds DTS for N950/N9 and removes the legacy board file. However,
I guess the HACK in patch 1 needs to be solved somehow before we can
do this...

Aaro Koskinen (3):
  ARM: OMAP2: HACK: hardcode hsmmc2 input clock source for N950/N9
  ARM: dts: add minimal DT support for Nokia N950 & N9 phones
  ARM: OMAP2: delete board-rm680

 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/omap3-n9.dts       |  18 ++++
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 172 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-n950.dts     |  18 ++++
 arch/arm/mach-omap2/Kconfig          |   7 --
 arch/arm/mach-omap2/Makefile         |   1 -
 arch/arm/mach-omap2/board-generic.c  |  15 +++
 arch/arm/mach-omap2/board-rm680.c    | 167 ----------------------------------
 8 files changed, 225 insertions(+), 175 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-n9.dts
 create mode 100644 arch/arm/boot/dts/omap3-n950-n9.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-n950.dts
 delete mode 100644 arch/arm/mach-omap2/board-rm680.c

-- 
1.8.4.rc3
