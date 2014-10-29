From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 29 Oct 2014 16:36:30 +0200
Subject: [PATCH] ARM: dts: imx6dl: add alias for I2C4 bus
Message-ID: <1414593390-30068-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On registration I2C bus drivers attemp to get ids from device tree
aliases, add a missing alias for I2C4 found on iMX6 DualLite/Solo.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index b453e0e..44d8876 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -13,6 +13,10 @@
 #include "imx6qdl.dtsi"
 
 / {
+	aliases {
+		i2c3 = &i2c4;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.7.10.4
