From: tony@atomide.com (Tony Lindgren)
Date: Tue,  3 Dec 2013 15:23:18 -0800
Subject: [PATCH 4/5] ARM/dts: Add basic devices on am3517-evm
In-Reply-To: <1386112999-17271-1-git-send-email-tony@atomide.com>
References: <1386112999-17271-1-git-send-email-tony@atomide.com>
Message-ID: <1386112999-17271-5-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's add the Ethernet so NFSroot works and the first MMC card
so people can patch in more support easily.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am3517-evm.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index 03fcbf0..b4127c6 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -17,6 +17,21 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
+
+        vmmc_fixed: vmmc {
+                compatible = "regulator-fixed";
+                regulator-name = "vmmc_fixed";
+                regulator-min-microvolt = <3300000>;
+                regulator-max-microvolt = <3300000>;
+        };
+};
+
+&davinci_emac {
+	     status = "okay";
+};
+
+&davinci_mdio {
+	     status = "okay";
 };
 
 &i2c1 {
@@ -30,3 +45,17 @@
 &i2c3 {
 	clock-frequency = <400000>;
 };
+
+&mmc1 {
+	vmmc-supply = <&vmmc_fixed>;
+	bus-width = <4>;
+};
+
+&mmc2 {
+      status = "disabled";
+};
+
+&mmc3 {
+      status = "disabled";
+};
+
-- 
1.8.1.1
