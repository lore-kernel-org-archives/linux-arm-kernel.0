From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 23 Feb 2015 18:40:10 +0100
Subject: [PATCH v9 0/5] i.MX6 PU power domain support
Message-ID: <1424713215-3357-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this is a rebased and updated version of the series I sent previously:

http://www.spinics.net/lists/arm-kernel/msg360709.html

Changes since v8:
 - Updated DT documentation example with IRQ_TYPE_... and
   IMX6QDL_CLK_... defines
 - Made PU regulator optional to support i.MX6SX, suggested by
   Robin Gong
 - Removed regulator_enable() call in the probe function, stopped
   disabling the regulator in imx6q_pm_pu_power_off() - the regulator
   framework will disable unused regulators.
 - Changed the GPC driver to enable pu power if CONFIG_PM is not
   enabled, as some bootloaders disable pu power on boot.

regards
Philipp

Philipp Zabel (6):
  Documentation: Add device tree bindings for Freescale i.MX GPC
  ARM: imx6: gpc: Add PU power domain for GPU/VPU
  ARM: dts: imx6qdl: Add power-domain information to gpc node
  ARM: dts: imx6sl: Add power-domain information to gpc node
  ARM: dts: imx6qdl: Allow disabling the PU regulator, add a enable ramp
    delay
  ARM: imx6: gpc: Allow PU regulator bypass

 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  59 ++++++
 arch/arm/boot/dts/imx6qdl.dtsi                     |  10 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   4 +
 arch/arm/mach-imx/Kconfig                          |   1 +
 arch/arm/mach-imx/gpc.c                            | 216 +++++++++++++++++++++
 5 files changed, 289 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt

-- 
2.1.4
