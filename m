From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:11 +0100
Subject: [PATCH 05/13] ARM: dts: omap3-gta04: Fix a GPIO line for bma180 node
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-6-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO_115 used as irq is in &gpio4, not &gpio3.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index fd6ac80..0265474 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -230,7 +230,7 @@
 	bma180 at 41 {
 		compatible = "bosch,bma180";
 		reg = <0x41>;
-		interrupt-parent = <&gpio3>;
+		interrupt-parent = <&gpio4>;
 		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-- 
1.9.1
