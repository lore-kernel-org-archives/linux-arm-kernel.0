From: yao.yuan@freescale.com (Yuan Yao)
Date: Wed, 16 Sep 2015 16:20:43 +0800
Subject: [PATCH] arm/dts: Add node for ina220 on LS1021ATWR
Message-ID: <1442391643-37883-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The INA220 monitors both shunt drop and supply voltage.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index e008f93..fbb89d1 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -144,6 +144,19 @@
 
 &i2c0 {
 	status = "okay";
+
+	ina220 at 40 {
+		compatible = "ti,ina220";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+
+	ina220 at 41 {
+		compatible = "ti,ina220";
+		reg = <0x41>;
+		shunt-resistor = <1000>;
+	};
+
 };
 
 &i2c1 {
-- 
2.1.0.27.g96db324
