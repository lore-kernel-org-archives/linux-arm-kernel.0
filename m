From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  7 Mar 2015 20:01:23 +0100
Subject: [PATCH 6/7] ARM: dts: sun7i: Add OOB irq support to boards with
 broadcom sdio wifi
In-Reply-To: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
References: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1425754884-7875-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 11 +++++++++++
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts  | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 0c219a4..8111b0c 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -167,12 +167,23 @@
 };
 
 &mmc3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins_a>;
 	vmmc-supply = <&reg_vmmc3>;
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
+
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <10 8>; /* PH10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
 };
 
 &mmc3_pins_a {
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index baee563..4a8defd 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -164,12 +164,23 @@
 };
 
 &mmc3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins_a>;
 	vmmc-supply = <&reg_vmmc3>;
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
+
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <10 8>; /* PH10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
 };
 
 &mmc3_pins_a {
-- 
2.3.1
