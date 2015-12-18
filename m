From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:11:45 +0900
Subject: [PATCH 3/3] ARM: shmobile: r8a7794: use fallback usbhs compatibility
 string
In-Reply-To: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
References: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1450404705-5449-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7794 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 6c78f1fae90f..e0b2e97da598 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -724,7 +724,7 @@
 	};
 
 	hsusb: usb at e6590000 {
-		compatible = "renesas,usbhs-r8a7794";
+		compatible = "renesas,usbhs-r8a7794", "renesas,usbhs";
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
-- 
2.1.4
