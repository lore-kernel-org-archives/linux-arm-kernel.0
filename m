From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Mar 2016 17:38:42 +0100
Subject: [PATCH v3 19/19] ARM: sun5i: chip: Enable the TV Encoder
In-Reply-To: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1458751122-23976-20-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CHIP has a composite output available muxed with the microphone in the
micro-jack plug.

Enable the composite output in its DTS.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index f6898c6b84d4..a8d8b4582397 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -66,6 +66,10 @@
 	};
 };
 
+&be0 {
+	status = "okay";
+};
+
 &codec {
 	status = "okay";
 };
@@ -188,6 +192,14 @@
 	status = "okay";
 };
 
+&tcon0 {
+	status = "okay";
+};
+
+&tve0 {
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins_b>;
-- 
2.7.3
