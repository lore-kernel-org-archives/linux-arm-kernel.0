From: anton_bondarenko@mentor.com (Anton Bondarenko)
Date: Tue, 13 Jan 2015 19:04:08 +0100
Subject: [PATCH v2] ARM: dts: imx6q: enable dma for ecspi5
In-Reply-To: <315825>
References: <315825>
Message-ID: <1421172248-15765-1-git-send-email-anton_bondarenko@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable dma support for ecspi5 controller

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
