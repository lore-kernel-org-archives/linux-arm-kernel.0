From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 24 Sep 2013 22:28:14 +0300
Subject: [PATCH v2 0/3] ARM: OMAP: convert N950/N9 to DT
Message-ID: <1380050897-6605-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This adds DTS for N950/N9 and removes the legacy board file.

The following patches needs to be applied first:

   http://marc.info/?l=linux-omap&m=137969869426861&w=2 (the whole series)
   [PATCH 0/4] Clean up legacy platform data handling for omaps for v3.13

   http://marc.info/?l=linux-omap&m=137970770229676&w=2
   [PATCH] ARM: OMAP2: gpmc-onenand: fix sync mode setup with DT

Change history:

	v2: Replace patch 1 HACK by using pdata-quirks

	v1: http://marc.info/?l=linux-omap&m=137977135411888&w=2

A.

Aaro Koskinen (3):
  ARM: OMAP2: pdata-quirks: set internal clock source for MMC2 on
    N950/N9
  ARM: dts: add minimal DT support for Nokia N950 & N9 phones
  ARM: OMAP2: delete board-rm680

 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/omap3-n9.dts       |  18 ++++
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 172 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-n950.dts     |  18 ++++
 arch/arm/mach-omap2/Kconfig          |   7 --
 arch/arm/mach-omap2/Makefile         |   1 -
 arch/arm/mach-omap2/board-rm680.c    | 167 ----------------------------------
 arch/arm/mach-omap2/pdata-quirks.c   |  16 ++++
 8 files changed, 226 insertions(+), 175 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-n9.dts
 create mode 100644 arch/arm/boot/dts/omap3-n950-n9.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-n950.dts
 delete mode 100644 arch/arm/mach-omap2/board-rm680.c

-- 
1.8.4.rc3
