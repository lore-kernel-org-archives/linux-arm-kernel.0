From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 3 Oct 2013 13:13:13 -0700
Subject: [PATCH 5/6] ARM: dts: Specify clocks for timer on bcm11351
In-Reply-To: <1380831194-27238-1-git-send-email-tim.kryger@linaro.org>
References: <1380831194-27238-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1380831194-27238-6-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify the external clock label in the timer node.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index d1ce441..22aef21 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -95,7 +95,7 @@
 		compatible = "brcm,kona-timer";
 		reg = <0x35006000 0x1000>;
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-		clock-frequency = <32768>;
+		clocks = <&hub_timer_clk>;
 	};
 
 	sdio1: sdio at 3f180000 {
-- 
1.8.0.1
