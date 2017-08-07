From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon,  7 Aug 2017 16:13:21 +0800
Subject: [PATCH 3/7] arm64: dts: hi3660: add pmu dt node for hi3660
In-Reply-To: <20170807081325.11406-1-guodong.xu@linaro.org>
References: <20170807081325.11406-1-guodong.xu@linaro.org>
Message-ID: <20170807081325.11406-4-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: YiPing Xu <xuyiping@hisilicon.com>

Add pmu dt node for hi3660

Signed-off-by: YiPing Xu <xuyiping@hisilicon.com>
Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Jumana Mundichipparakkal <jumana.mp@arm.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 1cdd03b..5fd5686 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -202,6 +202,26 @@
 					 IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>,
+				     <&cpu2>,
+				     <&cpu3>,
+				     <&cpu4>,
+				     <&cpu5>,
+				     <&cpu6>,
+				     <&cpu7>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-- 
2.10.2
