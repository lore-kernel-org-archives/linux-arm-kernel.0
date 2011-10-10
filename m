From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 10 Oct 2011 13:33:05 +0530
Subject: [PATCH V3 0/4]: ARM: SAMSUNG: Add SPI clkdev support
Message-ID: <1318233789-19882-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset modifies the existing clkdev to make SPI driver
independent of the clock names send from platform data. This
patches enables the SPI driver to request SPI bus clocks
using generic connection ID.

V1 patch series are:
	http://www.spinics.net/lists/arm-kernel/msg141671.html

Changes since V1:
	-Add newly introduced CLKDEV_INIT macro for creating clk_lookup
	structure as suggested by Russell King
	V2 patches series are:
	http://www.spinics.net/lists/arm-kernel/msg142733.html

Changes since V2:
	-Reworked the patches as per the following link. Patch series in
	the following link removed & and , from the macro declaration and added
	in the macro defination. 
	http://www.spinics.net/lists/arm-kernel/msg143663.html

Padmavathi Venna (4):
  ARM: S3C64XX: Add SPI clkdev support
  ARM: S5PC100: Add SPI clkdev support
  ARM: S5P64X0: Add SPI clkdev support
  ARM: S5PV210: Add SPI clkdev support

 arch/arm/mach-s3c64xx/clock.c         |   98 ++++++++++++++++--------
 arch/arm/mach-s5p64x0/clock-s5p6440.c |   57 +++++++++-----
 arch/arm/mach-s5p64x0/clock-s5p6450.c |   57 +++++++++-----
 arch/arm/mach-s5pc100/clock.c         |  132 ++++++++++++++++++++-------------
 arch/arm/mach-s5pv210/clock.c         |   58 ++++++++++-----
 5 files changed, 259 insertions(+), 143 deletions(-)

-- 
1.7.4.4
