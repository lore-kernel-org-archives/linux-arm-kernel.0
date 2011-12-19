From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 19 Dec 2011 11:21:41 +0800
Subject: [PATCH V3 5/7] dts/imx6q: add cpufreq property
In-Reply-To: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1324264903-15395-6-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 263e8f3..80e47b5 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -26,9 +26,12 @@
 		#size-cells = <0>;
 
 		cpu at 0 {
-			compatible = "arm,cortex-a9";
+			compatible = "arm,cortex-a9", "generic-cpufreq";
 			reg = <0>;
 			next-level-cache = <&L2>;
+			cpu-freqs = <996000000 792000000 396000000 198000000>;
+			cpu-volts = <1225000 1100000 950000 850000>;
+			trans-latency = <61036>; /* two CLK32 periods */
 		};
 
 		cpu at 1 {
-- 
1.7.5.4
