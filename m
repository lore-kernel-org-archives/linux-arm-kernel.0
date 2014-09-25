From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 25 Sep 2014 11:54:50 +0200
Subject: [PATCH v2 0/2] serial: samsung: add support for early console
Message-ID: <1411638892-13702-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for early console defined in device tree. As
an example, DTS files for all Exynos4 based machines are updated with
the correct value for common chosen/sdtout property.

To get it fully functional on ARM architecture, additional improvements
(support for early_ioremap) are needed in early console code.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Change log:

v2:
- added support for command line based initialization

v1: http://www.spinics.net/lists/linux-samsung-soc/msg37094.html
- initial version


Patch summary:

Tomasz Figa (2):
  serial: samsung: Add support for early console
  ARM: dts: exynos4: Add stdout-path properties

 Documentation/kernel-parameters.txt             |  10 +++
 arch/arm/boot/dts/exynos4210-origen.dts         |   1 +
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |   1 +
 arch/arm/boot/dts/exynos4210-trats.dts          |   1 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts |   1 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   4 +
 arch/arm/boot/dts/exynos4412-origen.dts         |   1 +
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |   1 +
 arch/arm/boot/dts/exynos4412-tiny4412.dts       |   4 +
 arch/arm/boot/dts/exynos4412-trats2.dts         |   1 +
 drivers/tty/serial/Kconfig                      |   1 +
 drivers/tty/serial/samsung.c                    | 103 ++++++++++++++++++++++++
 12 files changed, 129 insertions(+)

-- 
1.9.2
