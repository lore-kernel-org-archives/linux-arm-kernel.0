From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 15 Dec 2015 15:09:05 +0530
Subject: [PATCH v3 3/4] ARM: dts: dra7: Use "ti,
 dra7x-usb2-phy2" compatible string for USB2 PHY2
In-Reply-To: <1450172346-11890-1-git-send-email-kishon@ti.com>
References: <1450172346-11890-1-git-send-email-kishon@ti.com>
Message-ID: <1450172346-11890-4-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB2 PHY2 has a different register map compared to USB2 PHY1
to power on/off the PHY. In order to handle it, use the new compatible
string "ti,dra7x-usb2-phy2" for the second instance of USB2 PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 156d735..41545f9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1299,7 +1299,8 @@
 			};
 
 			usb2_phy2: phy at 4a085000 {
-				compatible = "ti,omap-usb2";
+				compatible = "ti,dra7x-usb2-phy2",
+					     "ti,omap-usb2";
 				reg = <0x4a085000 0x400>;
 				ctrl-module = <&omap_control_usb2phy2>;
 				clocks = <&usb_phy2_always_on_clk32k>,
-- 
1.7.9.5
