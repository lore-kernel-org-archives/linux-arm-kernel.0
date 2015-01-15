From: alison@she-devel.com (alison at she-devel.com)
Date: Thu, 15 Jan 2015 10:46:10 -0800
Subject: [PATCHv2] i.MX6-SabreAuto: WEIM: add steering-gpios to set WEIM for
 NOR
In-Reply-To: <20150115075646.GM23940@pengutronix.de>
References: <20150115075646.GM23940@pengutronix.de>
Message-ID: <1421347571-9239-1-git-send-email-alison_chaiken@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alison Chaiken <alison_chaiken@mentor.com>

The EIM switch of the i.MX6 SabreAuto CPU cards can connect pins
EIM_D18 and EIM_D30 of the CPU to either the parallel NOR or to other
peripherals.  Add a steering-gpios property to the imx6qdl-sabreauto
device-tree to allow boot-time configuration of the EIM.  Use GPIO5,
pin 4 to connect EIM_D18 to the NOR so the do_map_probe() function
correctly detects the CFI.

Support is not added for boot-time steering of EIM_D30 due to present
inability to test.

Alison Chaiken (1):
  i.MX6-SabreAuto: WEIM: add steering-gpios to set WEIM for NOR

 Documentation/devicetree/bindings/bus/imx-weim.txt | 10 +++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |  1 +
 drivers/bus/imx-weim.c                             | 46 ++++++++++++++++++++++
 3 files changed, 57 insertions(+)

-- 
2.1.4
