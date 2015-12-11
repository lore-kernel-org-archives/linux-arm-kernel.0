From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 11 Dec 2015 18:31:47 +0000
Subject: [PATCH 2/4] arm: dts: apq8064: add shared memory into dt
 reserved-memory
In-Reply-To: <1449858409-13296-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1449858409-13296-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1449858707-13517-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the shared memory in the Device tree reserved memory
list so that kernel would not map it as normal memory.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a4c1762..09f0e27 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -11,6 +11,17 @@
 	compatible = "qcom,apq8064";
 	interrupt-parent = <&intc>;
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		smem:smem at 80000000 {
+			reg = <0x80000000 0x200000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.9.1
