From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Apr 2016 07:55:38 +0800
Subject: [PATCH v4 02/16] arm64: dts: add sp804 timer node for Hi6220
In-Reply-To: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
References: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1460505352-13157-3-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

Add sp804 timer for hi6220, so it can be used as broadcast timer.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index ad1f1eb..b975286 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -209,5 +209,16 @@
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
+
+		dual_timer0: timer at f8008000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x0 0xf8008000 0x0 0x1000>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ao_ctrl HI6220_TIMER0_PCLK>,
+				 <&ao_ctrl HI6220_TIMER0_PCLK>,
+				 <&ao_ctrl HI6220_TIMER0_PCLK>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+		};
 	};
 };
-- 
1.9.1
