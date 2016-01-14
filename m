From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Jan 2016 16:25:06 +0100
Subject: [PATCH v2 23/26] ARM: sun5i: chip: Enable the TV Encoder
In-Reply-To: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1452785109-6172-24-git-send-email-maxime.ripard@free-electrons.com>
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
index c976c7618118..c26c095b42c6 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -84,6 +84,10 @@
 	};
 };
 
+&be0 {
+	status = "okay";
+};
+
 &codec {
 	status = "okay";
 };
@@ -230,6 +234,14 @@
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
2.6.4
