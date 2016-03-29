From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 29 Mar 2016 19:27:14 +0800
Subject: [PATCH v3 3/4] arm64: dts: register Hi6220's thermal sensor
In-Reply-To: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
References: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1459250835-25561-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bind thermal sensor driver for Hi6220.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index f588be9..50ba1b0 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -313,5 +313,14 @@
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			#mbox-cells = <3>;
 		};
+
+		tsensor: tsensor at 0,f7030700 {
+			compatible = "hisilicon,tsensor";
+			reg = <0x0 0xf7030700 0x0 0x1000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_ctrl 22>;
+			clock-names = "thermal_clk";
+			#thermal-sensor-cells = <1>;
+		};
 	};
 };
-- 
1.9.1
