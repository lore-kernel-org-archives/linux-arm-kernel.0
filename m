From: anton_bondarenko@mentor.com (Anton Bondarenko)
Date: Tue, 13 Jan 2015 18:23:17 +0100
Subject: [PATCH] ARM: dts: imx6q: enable dma for ecspi5
Message-ID: <1421169797-14213-1-git-send-email-anton_bondarenko@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable dma support for espci5 controller

Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
---
 arch/arm/boot/dts/imx6q.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 37ee4e5..93ec79b 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -95,6 +95,8 @@
 					clocks = <&clks IMX6Q_CLK_ECSPI5>,
 						 <&clks IMX6Q_CLK_ECSPI5>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 11 7 1>, <&sdma 12 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 			};
-- 
2.2.1
