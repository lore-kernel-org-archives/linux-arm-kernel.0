From: lucile.quirion@savoirfairelinux.com (Lucile Quirion)
Date: Tue,  9 Aug 2016 11:15:42 -0400
Subject: [PATCH v3 0/2] Add board support for TS-4900
Message-ID: <1470755744-7837-1-git-send-email-lucile.quirion@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch serie adds support for TS-4900 System on Module (SoM). This board,
manufactured by Technologic Systems, is based on an i.MX6.

The i.MX6 exists in 2 flavours: single/dualcore or quadcore. I've added TS-4900
device tree files for both flavour of the i.MX6.

The current device tree does NOT include the FPGA's GPIOs, the FPGA's UARTs
or the wireless chip.

I'd like your input about this problem:

The TS-4900 can be mounted on several carrier boards providing additional
peripheral connectors (e.g. TS-TPC-8390). A final device tree would include the
dtsi defining the carrier board's peripherals.

Should there be a dts file per SoM and carrier board combination ?

There is a already a total of 30 combinations on Technologic's website:
https://www.embeddedarm.com/products/category/modular-embedded-systems

Changes in v2:
 - fix copyright notices
 - re-license dts files with Technologic Systems's agreement
 - reorder 'status' priority
 - remove 'regulator-always-on'

Changes in v3:
 - remove unused #include from dts files
 - use generic node names (flash, rtc, gpio)
 - remove the flash partition table
 - use consistent naming across pinctrl configuration
 - do not configure reserved pad settings for RGMII
 - remove duplicated pin setting MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK
 - use uart-has-rtscts instead of fsl,uart-has-rtscts
 - remove fsl,wp-controller property from the eMMC node


Lucile Quirion (2):
  of: documentation: add bindings documentation for TS-4900
  ARM: dts: TS-4900: add basic device tree

 .../devicetree/bindings/arm/technologic.txt        |   6 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx6dl-ts4900.dts                |  49 +++
 arch/arm/boot/dts/imx6q-ts4900.dts                 |  53 +++
 arch/arm/boot/dts/imx6qdl-ts4900.dtsi              | 481 +++++++++++++++++++++
 5 files changed, 591 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-ts4900.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ts4900.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-ts4900.dtsi

-- 
2.5.5
