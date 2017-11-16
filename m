From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 16 Nov 2017 17:01:15 +0800
Subject: [PATCH v5 2/2] ARM: dts: meson: drop "sana" clock from SAR ADC
In-Reply-To: <20171116090115.29915-1-yixun.lan@amlogic.com>
References: <20171116090115.29915-1-yixun.lan@amlogic.com>
Message-ID: <20171116090115.29915-3-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

The SAR ADC modules doesn't require The "sana" clock.

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm/boot/dts/meson8.dtsi  | 5 ++---
 arch/arm/boot/dts/meson8b.dtsi | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index b98d44fde6b6..f93d6cf6e094 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -289,9 +289,8 @@
 &saradc {
 	compatible = "amlogic,meson8-saradc", "amlogic,meson-saradc";
 	clocks = <&clkc CLKID_XTAL>,
-		<&clkc CLKID_SAR_ADC>,
-		<&clkc CLKID_SANA>;
-	clock-names = "clkin", "core", "sana";
+		<&clkc CLKID_SAR_ADC>;
+	clock-names = "clkin", "core";
 };
 
 &spifc {
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index bc278da7df0d..4aa444284f0c 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -185,9 +185,8 @@
 &saradc {
 	compatible = "amlogic,meson8b-saradc", "amlogic,meson-saradc";
 	clocks = <&clkc CLKID_XTAL>,
-		<&clkc CLKID_SAR_ADC>,
-		<&clkc CLKID_SANA>;
-	clock-names = "clkin", "core", "sana";
+		<&clkc CLKID_SAR_ADC>;
+	clock-names = "clkin", "core";
 };
 
 &uart_AO {
-- 
2.14.1
