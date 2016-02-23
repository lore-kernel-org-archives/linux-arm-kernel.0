From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 23 Feb 2016 10:17:45 +0900
Subject: [PATCH 1/2] ARM: dts: r8a7790: use fallback etheravb compatibility
 string
In-Reply-To: <1456190266-3781-1-git-send-email-horms+renesas@verge.net.au>
References: <1456190266-3781-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1456190266-3781-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7790 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ba4c2530d79f..ec933f6ff5bf 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -773,7 +773,7 @@
 	};
 
 	avb: ethernet at e6800000 {
-		compatible = "renesas,etheravb-r8a7790";
+		compatible = "renesas,etheravb-r8a7790", "renesas,etheravb-rcar-gen2";
 		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_ETHERAVB>;
-- 
2.1.4
