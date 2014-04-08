From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  8 Apr 2014 16:00:52 +0800
Subject: [PATCH v2 12/12] ARM: dts: Add PMU support in HiP04
In-Reply-To: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1396944052-9887-13-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kefeng Wang <kefeng.wang@linaro.org>

ARM Performance Monitor Units are available on the HiP04.
So add the support in the dtsi.

Simply tested with perf.

Signed-off-by: Kefeng Wang <kefeng.wang@linaro.org>
Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/hip04.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index eb5e5a2..0ad1e7b 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -219,6 +219,26 @@
 			status = "ok";
 		};
 
+		arm-pmu {
+			compatible = "arm,cortex-a15-pmu";
+			interrupts = <0 64 4>,
+				     <0 65 4>,
+				     <0 66 4>,
+				     <0 67 4>,
+				     <0 68 4>,
+				     <0 69 4>,
+				     <0 70 4>,
+				     <0 71 4>,
+				     <0 72 4>,
+				     <0 73 4>,
+				     <0 74 4>,
+				     <0 75 4>,
+				     <0 76 4>,
+				     <0 77 4>,
+				     <0 78 4>,
+				     <0 79 4>;
+		};
+
 		timer {
 			compatible = "arm,armv7-timer";
 			interrupts = <1 13 0xf08>,
-- 
1.8.3.2
