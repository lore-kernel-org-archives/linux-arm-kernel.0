From: avinashphilip@ti.com (Philip Avinash)
Date: Wed, 27 Mar 2013 13:13:56 +0530
Subject: [PATCH 0/3] DT support for da850-evm LCD
Message-ID: <1364370239-18390-1-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for da850-evm LCD.
Depends on [1], [2] and [3] and based on 3.9.rc4.
Tested on da850-evm and available for testing at [4]

1. video: da8xx-fb: am335x DT support
   https://lkml.org/lkml/2013/1/28/90
2. video: da8xx-fb: runtime timing configuration.
   https://lkml.org/lkml/2013/1/15/241
3. Platform support for EHRPWM & ECAP devices in DAVINCI.
   http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2013-March/026798.html
4. https://github.com/avinashphilip/am335x_linux/tree/da850_lcd_dt_support 

Testing:
LCD panel back light should enabled through PWM. But back light goes off on SPI
transactions as spi1_cs0 will be the source for LCD back light power (provided
SPI flash support enabled).

Philip Avinash (3):
  ARM: davinci: da850: Add LCDC DT entries
  ARM: davinci: da850: override LCDC DT node device name
  ARM: davinci: da850 evm: Add da850-evm LCD panel support

 arch/arm/boot/dts/da850-evm.dts  |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     |   21 +++++++++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |    1 +
 3 files changed, 44 insertions(+)

-- 
1.7.9.5
