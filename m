From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon, 14 Aug 2017 17:50:49 +0800
Subject: [PATCH v3 10/10] arm64: dts: hi3660: enable watchdog
In-Reply-To: <20170814095049.27701-1-guodong.xu@linaro.org>
References: <20170814095049.27701-1-guodong.xu@linaro.org>
Message-ID: <20170814095049.27701-11-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

This patch is to add watchdog binding for Hi3660 on Hikey960 board.

Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Zhong Kaihua <zhongkaihua@huawei.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 545d435..b7a90d6 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -962,5 +962,21 @@
 				     &sdio_cfg_func>;
 			status = "disabled";
 		};
+
+		watchdog0: watchdog at e8a06000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xe8a06000 0x0 0x1000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_OSC32K>;
+			clock-names = "apb_pclk";
+		};
+
+		watchdog1: watchdog at e8a07000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xe8a07000 0x0 0x1000>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_OSC32K>;
+			clock-names = "apb_pclk";
+		};
 	};
 };
-- 
2.10.2
