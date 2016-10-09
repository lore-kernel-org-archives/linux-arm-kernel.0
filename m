From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun,  9 Oct 2016 14:27:14 +0800
Subject: [PATCH v2 4/4] ARM: sunxi: enable battery on reference design tablets
In-Reply-To: <20161009062714.5085-1-icenowy@aosc.xyz>
References: <20161009062714.5085-1-icenowy@aosc.xyz>
Message-ID: <20161009062714.5085-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since battery is one part of the reference design of Allwinner tablets,
enable the battery node of reference design tablets.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes since v1:
- Applied to reference design tablet, not Q8 only now.
- Add support for sun5i reference design tablet.

 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 4 ++++
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index 20cc940..9e17b46 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -92,6 +92,10 @@
 
 #include "axp209.dtsi"
 
+&battery {
+	status = "okay";
+};
+
 &lradc {
 	vref-supply = <&reg_ldo2>;
 };
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 9d90361..74517ab 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -112,6 +112,10 @@
 
 #include "axp22x.dtsi"
 
+&battery {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <3000000>;
-- 
2.10.0
