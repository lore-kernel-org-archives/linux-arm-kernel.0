From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 30 Mar 2017 16:10:19 +0800
Subject: [PATCH v6 3/3] ARM: sunxi: h3/h5: enable SID on Allwinner H3/H5 SoC
In-Reply-To: <20170330081019.59979-1-icenowy@aosc.io>
References: <20170330081019.59979-1-icenowy@aosc.io>
Message-ID: <20170330081019.59979-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.xyz>

As we have already made sunxi_sid driver support the SID controller on
H3/H5, enable it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v6:
- Rebased on current linux-next.
- Change H3 in commit message to H3/H5.

 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 6640ebfa6419..30b25e4fc342 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -144,6 +144,11 @@
 			#size-cells = <0>;
 		};
 
+		sid: eeprom at 01c14000 {
+			compatible = "allwinner,sun8i-h3-sid";
+			reg = <0x01c14000 0x400>;
+		};
+
 		usb_otg: usb at 01c19000 {
 			compatible = "allwinner,sun8i-h3-musb";
 			reg = <0x01c19000 0x400>;
-- 
2.12.0
