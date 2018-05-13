From: hernan@vanguardiasur.com.ar (=?UTF-8?q?Hern=C3=A1n=20Gonzalez?=)
Date: Sun, 13 May 2018 20:24:54 -0300
Subject: [PATCH] ARM: dts: vf-colibri-eval-v3.dtsi: Use IRQ_TYPE specifier
Message-ID: <1526253894-3709-1-git-send-email-hernan@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO_ACTIVE_LOW was being used to specify an interrupt, use
IRQ_TYPE_EDGE_RISING instead. This improves DT readability.

Signed-off-by: Hern?n Gonzalez <hernan@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index d8b2972..e2da122 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -117,7 +117,7 @@
 		clocks = <&clk16m>;
 		spi-max-frequency = <10000000>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <11 GPIO_ACTIVE_LOW>;
+		interrupts = <11 IRQ_TYPE_EDGE_RISING>;
 	};
 };
 
-- 
2.7.4
