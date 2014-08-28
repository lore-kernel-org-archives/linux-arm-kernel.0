From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 28 Aug 2014 23:16:17 +0800
Subject: [PATCH v3 3/3] ARM: dts: hix5hd2: add ir node
In-Reply-To: <1409238977-19444-1-git-send-email-zhangfei.gao@linaro.org>
References: <1409238977-19444-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1409238977-19444-4-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 7b1cb53..1d7cd04 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -391,7 +391,7 @@
 		};
 
 		sysctrl: system-controller at 00000000 {
-			compatible = "hisilicon,sysctrl";
+			compatible = "hisilicon,sysctrl", "syscon";
 			reg = <0x00000000 0x1000>;
 			reboot-offset = <0x4>;
 		};
@@ -476,5 +476,13 @@
                         interrupts = <0 70 4>;
                         clocks = <&clock HIX5HD2_SATA_CLK>;
 		};
+
+		ir: ir at 001000 {
+			compatible = "hisilicon,hix5hd2-ir";
+			reg = <0x001000 0x1000>;
+			interrupts = <0 47 4>;
+			clocks = <&clock HIX5HD2_FIXED_24M>;
+			hisilicon,power-syscon = <&sysctrl>;
+		};
 	};
 };
-- 
1.7.9.5
