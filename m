From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 10 Oct 2017 20:02:50 +0200
Subject: [PATCH 25/25] arm64: dts: Register Hi3660's thermal sensor
In-Reply-To: <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1507658570-32675-25-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

Add binding for tsensor on H3660, this tsensor is used for
SoC thermal control, it supports alarm interrupt.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index c6a1961..d9c0cf3 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -848,5 +848,13 @@
 				     &sdio_cfg_func>;
 			status = "disabled";
 		};
+
+		tsensor: tsensor at fff30000 {
+			compatible = "hisilicon,hi3660-tsensor";
+			reg = <0x0 0xfff30000 0x0 0x1000>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <1>;
+		};
+
 	};
 };
-- 
2.7.4
