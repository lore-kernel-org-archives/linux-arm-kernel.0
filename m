From: Akash_Gajjar@mentor.com (Akash Gajjar)
Date: Wed, 1 Aug 2018 13:13:19 +0530
Subject: [PATCH] arm64: dts: allwinner: a64: add csi regulator to sopine dts
In-Reply-To: <Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com>
Message-ID: <1533109399-21174-1-git-send-email-Akash_Gajjar@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sopine board has a csi. enable supply dvdd-1v8-csi, dovdd-2v8-csi and
avdd-2v8-csi on board to access external camera connected to it.

Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
---
 .../arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 43418bd..256229b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -68,6 +68,13 @@
 
 #include "axp803.dtsi"
 
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "dovdd-csi";
+};
+
 &reg_aldo2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1800000>;
@@ -112,6 +119,13 @@
 	regulator-name = "vdd-sys";
 };
 
+&reg_dldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "avdd-csi";
+};
+
 &reg_eldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <1800000>;
@@ -119,6 +133,13 @@
 	regulator-name = "vdd-1v8-lpddr";
 };
 
+&reg_eldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vdd-csi";
+};
+
 &reg_fldo1 {
 	regulator-min-microvolt = <1200000>;
 	regulator-max-microvolt = <1200000>;
-- 
2.7.4
