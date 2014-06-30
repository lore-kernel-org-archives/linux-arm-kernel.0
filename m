From: elder@linaro.org (Alex Elder)
Date: Mon, 30 Jun 2014 17:15:40 -0500
Subject: [PATCH v6 4/4] ARM: dts: enable SMP support for bcm21664
In-Reply-To: <1404166540-4457-1-git-send-email-elder@linaro.org>
References: <1404166540-4457-1-git-send-email-elder@linaro.org>
Message-ID: <1404166540-4457-5-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define nodes representing the two Cortex A9 CPUs in a bcm21644 SoC.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/boot/dts/bcm21664.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index 8b36682..2016b72 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -27,6 +27,25 @@
 		bootargs = "console=ttyS0,115200n8";
 	};
 
+       cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "brcm,bcm11351-cpu-method";
+		secondary-boot-reg = <0x35004178>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
 	gic: interrupt-controller at 3ff00100 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-- 
1.9.1
