From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue, 18 Nov 2014 11:13:19 +0200
Subject: [PATCH 4/9] ARM: dts: cm-t3x: add EEPROM support
In-Reply-To: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
References: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1416302004-22199-5-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add at24 EEPROM chip support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 3636fed..58205f0 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -155,12 +155,22 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
 	clock-frequency = <400000>;
+
+	at24 at 50 {
+		compatible = "at24,24c02";
+		pagesize = <16>;
+		reg = <0x50>;
+	};
 };
 
 &i2c3 {
 	clock-frequency = <400000>;
 };
+
 &usbhshost {
 	port1-mode = "ehci-phy";
 	port2-mode = "ehci-phy";
-- 
1.7.5.4
