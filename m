From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 10 Mar 2015 16:27:10 +0100
Subject: [PATCH v2 2/2] ARM: dts: sun7i: Add OOB irq support to boards with
 broadcom sdio wifi
In-Reply-To: <1426001230-15906-1-git-send-email-hdegoede@redhat.com>
References: <1426001230-15906-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1426001230-15906-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 8 ++++++++
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 012c337..d85ae00 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -173,6 +173,14 @@
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
+
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <10 IRQ_TYPE_LEVEL_LOW>; /* PH10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
 };
 
 &mmc3_pins_a {
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index baee563..c11574c 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -170,6 +170,14 @@
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
+
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <10 IRQ_TYPE_LEVEL_LOW>; /* PH10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
 };
 
 &mmc3_pins_a {
-- 
2.3.1
