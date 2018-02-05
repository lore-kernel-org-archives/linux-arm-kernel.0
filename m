From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Mon,  5 Feb 2018 16:46:49 +0200
Subject: [PATCH 2/4] arm64: dts: qcom: msm8916: Probe the APCS mailbox driver
In-Reply-To: <20180205144651.5934-1-georgi.djakov@linaro.org>
References: <20180205144651.5934-1-georgi.djakov@linaro.org>
Message-ID: <20180205144651.5934-2-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APCS block was exposed until now as a syscon, but now we have a
proper driver for this block. Add the compatible string of the new
driver to probe and register the mailbox functionality.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index d3592b19cfc9..5414f53a0fa1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -332,9 +332,10 @@
 			#clock-cells = <0>;
 		};
 
-		apcs: syscon at b011000 {
-			compatible = "syscon";
-			reg = <0x0b011000 0x1000>;
+		apcs: mailbox at b011000 {
+			compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
+			reg = <0xb011000 0x1000>;
+			#mbox-cells = <1>;
 		};
 
 		blsp1_uart2: serial at 78b0000 {
