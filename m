From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Mar 2016 11:01:07 +0900
Subject: [PATCH 1/3] ARM: dts: r8a7790: Use USB3.0 fallback compatibility
 string
In-Reply-To: <1458784869-17829-1-git-send-email-horms+renesas@verge.net.au>
References: <1458784869-17829-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458784869-17829-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7790 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 634f7e05ba6b..87005634b29b 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1539,7 +1539,7 @@
 	};
 
 	xhci: usb at ee000000 {
-		compatible = "renesas,xhci-r8a7790";
+		compatible = "renesas,xhci-r8a7790", "renesas,rcar-gen2-xhci";
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SSUSB>;
-- 
2.1.4
