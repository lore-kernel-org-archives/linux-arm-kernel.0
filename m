From: richard.zhao@linaro.org (Richard Zhao)
Date: Tue, 27 Dec 2011 16:24:20 +0800
Subject: [PATCH V5 5/7] dts/imx6q: add cpufreq property
In-Reply-To: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
References: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1324974262-30963-6-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 263e8f3..d89b42d 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -29,6 +29,13 @@
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			next-level-cache = <&L2>;
+			cpu-freqs = <996000000 792000000 396000000 198000000>;
+			cpu-volts = <	/* min		max */
+					1225000		1450000	/* 996M */
+					1100000		1450000	/* 792M */
+					950000		1450000	/* 396M */
+					850000		1450000>; /* 198M */
+			clk-trans-latency = <61036>; /* two CLK32 periods */
 		};
 
 		cpu at 1 {
-- 
1.7.5.4
