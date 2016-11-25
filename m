From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 25 Nov 2016 17:03:14 +0100
Subject: [PATCH 2/3] ARM: dts: da850: specify the maximum bandwidth for tilcdc
In-Reply-To: <1480089795-29811-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480089795-29811-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1480089795-29811-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It has been determined that the maximum resolution supported correctly
by tilcdc rev1 on da850 SoCs is 800x600 at 60. Due to memory throughput
constraints we must filter out higher modes.

Specify the max-bandwidth property for the display node for
da850-based boards.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 8e30d9b..9b7c444 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -452,6 +452,7 @@
 			compatible = "ti,da850-tilcdc";
 			reg = <0x213000 0x1000>;
 			interrupts = <52>;
+			max-bandwidth = <28800000>;
 			status = "disabled";
 
 			ports {
-- 
2.9.3
