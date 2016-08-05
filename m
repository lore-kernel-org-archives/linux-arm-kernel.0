From: kbeldan@baylibre.com (Karl Beldan)
Date: Fri,  5 Aug 2016 14:12:26 +0000
Subject: [PATCH v2 0/3] Support for the L138/C6748 Dev Kit (LCDK)
In-Reply-To: <20160804144332.4841-1-kbeldan@baylibre.com>
References: <20160804144332.4841-1-kbeldan@baylibre.com>
Message-ID: <20160805141229.20784-1-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This depends on "ARM: dts: da850: Add missing pin muxing for the UARTs".

Changes from v1:
 - s/omapl138/da850/
 - Remove earlycon from bootargs
 - Remove console=ttyS2,115200n8 from bootargs (workaround for preferred console)
 - Add patches for CONFIG_SMSC_PHY=y and CONFIG_RTC_DRV_OMAP=m

Karl Beldan (3):
  ARM: dts: da850: Add basic DTS for the L138/C6748 Dev Kit
  ARM: davinci_all_defconfig: enable RTC driver as module
  ARM: davinci_all_defconfig: enable SMSC ethernet PHY

 Documentation/devicetree/bindings/arm/davinci.txt |  4 ++
 arch/arm/boot/dts/Makefile                        |  1 +
 arch/arm/boot/dts/da850-lcdk.dts                  | 70 +++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig            |  2 +
 arch/arm/mach-davinci/da8xx-dt.c                  |  1 +
 5 files changed, 78 insertions(+)
 create mode 100644 arch/arm/boot/dts/da850-lcdk.dts

-- 
2.9.0.rc1
