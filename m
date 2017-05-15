From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 May 2017 11:25:09 -0300
Subject: [PATCH] ARM: dts: imx6sx-sdb: Properly model the ARM and SOC
 regulator supplies
Message-ID: <1494858309-10221-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On imx6sx-sdb rev B/C the VDD_ARM_IN and VDD_SOC_IN supplies are connected
together and both are supplied by the SW1A PMIC output, so model this
correctly in the device tree.

Suggested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index d71da30..c0139d7 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -128,3 +128,11 @@
 		reg = <1>;
 	};
 };
+
+&reg_arm {
+	vin-supply = <&sw1a_reg>;
+};
+
+&reg_soc {
+	vin-supply = <&sw1a_reg>;
+};
-- 
2.7.4
