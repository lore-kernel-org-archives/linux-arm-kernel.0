From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Mar 2016 11:01:08 +0900
Subject: [PATCH 2/3] ARM: dts: r8a7791: Use USB3.0 fallback compatibility
 string
In-Reply-To: <1458784869-17829-1-git-send-email-horms+renesas@verge.net.au>
References: <1458784869-17829-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458784869-17829-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7791 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 2c09f1a1cf37..8693888057ff 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1549,7 +1549,7 @@
 	};
 
 	xhci: usb at ee000000 {
-		compatible = "renesas,xhci-r8a7791";
+		compatible = "renesas,xhci-r8a7791", "renesas,rcar-gen2-xhci";
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SSUSB>;
-- 
2.1.4
