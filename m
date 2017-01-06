From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:19 +0100
Subject: [PATCH 10/25] ARM: dts: r8a7791: Use renesas,
 rcar-gen2-usb-phy fallback binding
In-Reply-To: <cover.1483700969.git.horms+renesas@verge.net.au>
References: <cover.1483700969.git.horms+renesas@verge.net.au>
Message-ID: <c39a6e76db7e1bc87b95f3dae7f7e4405f2854eb.1483700969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A fallback binding for the Renesas R-Car Gen2 PHY driver was
added by commit 7777cb8ba08d ("phy: rcar-gen2: add fallback binding").
This patch makes use of this binding in the DT for the r8a7791 SoC.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 87214668d70f..a5c596a15120 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -934,7 +934,8 @@
 	};
 
 	usbphy: usb-phy at e6590100 {
-		compatible = "renesas,usb-phy-r8a7791";
+		compatible = "renesas,usb-phy-r8a7791",
+			     "renesas,rcar-gen2-usb-phy";
 		reg = <0 0xe6590100 0 0x100>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.7.0.rc3.207.g0ac5344
