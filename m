From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Jan 2010 17:55:10 +0900
Subject: [PATCH v4 0/8] ARM: S5P6440: Add support for Samsung's S5P6440 SoC
Message-ID: <000d01ca9364$f2c8a990$d859fcb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This patches add basic support for Samsung's S5P6440 SoC.
The feature set that is added are clock, timer, uart and interrupts.

The clock changes are based on Harald Welte's patch. This patch is
also based on Ben's plat-samsung patch.

This patch set includes the following patches.

[PATCH v4 1/8] ARM: S5P6440: Add new CPU initialization support
[PATCH v4 2/8] ARM: S5P6440: Add Clock and PLL support
[PATCH v4 3/8] ARM: S5P6440: Add IRQ support
[PATCH v4 4/8] ARM: S5P6440: Add Timer support
[PATCH v4 5/8] ARM: S5P6440: Add new Kconfig and Makefiles
[PATCH v4 6/8] ARM: S5P6440: Add Board support file
[PATCH v4 7/8] ARM: S5P6440: Add configuration file
[PATCH v4 8/8] ARM: S5P6440: Add serial port support

This patch set depends on the following patches.

1. [PATCH 1/3] ARM: SAMSUNG: Add config option for number of additional GPIO
pins.
2. [PATCH 2/3] ARM: SAMSUNG: Make clk_default_setrate and clk_ops_def_setrate
visible to other code.
3. [PATCH 3/3] ARM: SAMSUNG: Add idle support.

Changes since v3:

1. Fixed code as per comments from Ben in linux-samsung-soc mailing list.

Changes since v2:

1. Removed unused clock module defines.
2. Modified PLL code to be generic.
3. IRQ Timer and IRQ UART code use common code.
4. S5P timer code is removed and common code in plat-s3c is used.
5. Moved some of the code from plat-s5p to plat-samsung.

Changes since v1:

1. Corrected parent clock sources for all the clocks.
2. Corrected the HCLK_LOW frequency calculation issue.
3. Added a menuconfig option "S5P_GPIO_EXTRA" to select the number
   of additional GPIO's required in file arch/arm/plat-s5p/Kconfig
4. Add PCLK_LOW and UCLK1 as clock sources for UART module.
5. Removed conditional inclusion of mach-s5p6440/Kconfig.
6. Other fixes and changes.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
