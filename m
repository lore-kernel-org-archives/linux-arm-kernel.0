From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Jan 2016 16:25:09 +0100
Subject: [PATCH v2 26/26] DO NOT MERGE: ARM: sun5i: chip: Enable the LCD panel
In-Reply-To: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1452785109-6172-27-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index c26c095b42c6..147c39106f63 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -82,6 +82,10 @@
 		vin0-supply = <&reg_ldo3>;
 		vin1-supply = <&reg_ldo4>;
 	};
+
+	panel: panel {
+		compatible = "olimex,lcd-olinuxino-43-ts";
+	};
 };
 
 &be0 {
@@ -236,6 +240,7 @@
 
 &tcon0 {
 	status = "okay";
+	allwinner,panel = <&panel>;
 };
 
 &tve0 {
-- 
2.6.4
