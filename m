From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu,  2 Feb 2017 21:13:38 +0800
Subject: [PATCH v3 3/3] ARM: dts: sun8i: enable SID on Allwinner H3 SoC
In-Reply-To: <20170202131338.20234-1-icenowy@aosc.xyz>
References: <20170202131338.20234-1-icenowy@aosc.xyz>
Message-ID: <20170202131338.20234-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have already made sunxi_sid driver support the SID controller on
H3, enable it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 08fd0860bb6b..0a7a38a75ee4 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -206,6 +206,11 @@
 			#size-cells = <0>;
 		};
 
+		sid: eeprom at 01c14000 {
+			compatible = "allwinner,sun8i-h3-sid";
+			reg = <0x01c14000 0x400>;
+		};
+
 		usbphy: phy at 01c19400 {
 			compatible = "allwinner,sun8i-h3-usb-phy";
 			reg = <0x01c19400 0x2c>,
-- 
2.11.0
