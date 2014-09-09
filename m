From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  9 Sep 2014 15:05:10 +0200
Subject: [PATCH v8 0/5] i.MX6 PU power domain support
Message-ID: <1410267915-18126-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is a rebased and updated version of the series I sent previously:

https://www.mail-archive.com/devicetree at vger.kernel.org/msg39278.html

It is based on the "PM / Domains: Generic OF-based support" series that Ulf
Hansson sent recently:

http://www.spinics.net/lists/linux-acpi/msg52439.html

Changes since v7:
 - Updated to v3 of the OF PM domain series
 - Fixed documentation to used proper property name 'power-domains'.
 - Made power domain registration depend on CONFIG_PM_GENERIC_DOMAINS
   instead of CONFIG_PM.

regards
Philipp

Philipp Zabel (5):
  Documentation: Add device tree bindings for Freescale i.MX GPC
  ARM: imx6: gpc: Add PU power domain for GPU/VPU
  ARM: dts: imx6qdl: Add power-domain information to gpc node
  ARM: dts: imx6sl: Add power-domain information to gpc node
  ARM: dts: imx6qdl: Allow disabling the PU regulator, add a enable ramp
    delay

 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  54 ++++++
 arch/arm/boot/dts/imx6qdl.dtsi                     |  11 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   4 +
 arch/arm/mach-imx/Kconfig                          |   1 +
 arch/arm/mach-imx/gpc.c                            | 203 +++++++++++++++++++++
 5 files changed, 272 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt

-- 
2.1.0
