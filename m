From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sat, 30 Aug 2014 12:15:42 +0800
Subject: [PATCH v3 6/6] ARM: dts: hix5hd2: add wdg node
In-Reply-To: <1409372142-5960-1-git-send-email-zhangfei.gao@linaro.org>
References: <1409372142-5960-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1409372142-5960-7-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 152f3ad..b3a87d7 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -365,6 +365,15 @@
 				#interrupt-cells = <2>;
 				status = "disabled";
 			};
+
+			wdt0: watchdog at a2c000 {
+				compatible = "arm,sp805", "arm,primecell";
+				arm,primecell-periphid = <0x00141805>;
+				reg = <0xa2c000 0x1000>;
+				interrupts = <0 29 4>;
+				clocks = <&clock HIX5HD2_WDG0_RST>;
+				clock-names = "apb_pclk";
+                       };
 		};
 
 		local_timer at 00a00600 {
-- 
1.7.9.5
