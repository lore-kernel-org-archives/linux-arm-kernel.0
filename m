From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Dec 2016 15:25:53 +0100
Subject: [PATCH 3/4] ARM: dts: r8a7794: Use renesas,
 rcar-gen2-usb-phy fallback binding
In-Reply-To: <1480602354-1446-1-git-send-email-horms+renesas@verge.net.au>
References: <1480602354-1446-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1480602354-1446-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A fallback binding for the Renesas R-Car Gen2 PHY driver was
added by commit 7777cb8ba08d ("phy: rcar-gen2: add fallback binding").
This patch makes use of this binding in the DT for the r8a7794 SoC.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 63dc7f29d216..5caa8b9181d8 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -878,7 +878,8 @@
 	};
 
 	usbphy: usb-phy at e6590100 {
-		compatible = "renesas,usb-phy-r8a7794";
+		compatible = "renesas,usb-phy-r8a7794",
+			     "renesas,rcar-gen2-usb-phy";
 		reg = <0 0xe6590100 0 0x100>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.7.0.rc3.207.g0ac5344
