From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Oct 2014 13:28:29 +0200
Subject: [PATCH v3 0/2] serial: samsung: add support for early console
Message-ID: <1413804511-32441-1-git-send-email-m.szyprowski@samsung.com>
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

v3:
- rebased onto v3.18-rc1
- removed options from documentation (they are not yet supported)

v2: http://www.spinics.net/lists/linux-samsung-soc/msg37278.html
- added support for command line based initialization

v1: http://www.spinics.net/lists/linux-samsung-soc/msg37094.html
- initial version

Tomasz Figa (2):
  serial: samsung: Add support for early console
  ARM: dts: exynos4: Add stdout-path properties

 Documentation/kernel-parameters.txt             |  12 +++
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
 12 files changed, 131 insertions(+)

-- 
1.9.2
