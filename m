From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 13 Oct 2015 08:58:15 +0800
Subject: [PATCH v2 3/4] arm64: dts: add sp804 timer node for Hi6220
In-Reply-To: <1444697896-4323-1-git-send-email-leo.yan@linaro.org>
References: <1444697896-4323-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1444697896-4323-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sp804 timer for hi6220, so it can be used as broadcast timer.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3f03380..cdd4125 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -167,5 +167,14 @@
 			clocks = <&ao_ctrl 36>, <&ao_ctrl 36>;
 			clock-names = "uartclk", "apb_pclk";
 		};
+
+		dual_timer0: dual_timer at f8008000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x0 0xf8008000 0x0 0x1000>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ao_ctrl 27>;
+			clock-names = "apb_pclk";
+		};
 	};
 };
-- 
1.9.1
