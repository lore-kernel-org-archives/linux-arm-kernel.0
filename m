From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Jan 2016 08:20:17 +1100
Subject: [PATCH v2 1/3] ARM: shmobile: r8a7790: use fallback usbhs
 compatibility string
In-Reply-To: <1451856019-4222-1-git-send-email-horms+renesas@verge.net.au>
References: <1451856019-4222-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1451856019-4222-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7790 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7dfd393bfc7e..4d9af0f46fab 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -746,7 +746,7 @@
 	};
 
 	hsusb: usb at e6590000 {
-		compatible = "renesas,usbhs-r8a7790";
+		compatible = "renesas,usbhs-r8a7790", "renesas,rcar-gen2-usbhs";
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
-- 
2.1.4
