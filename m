From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Apr 2016 07:55:48 +0800
Subject: [PATCH v4 12/16] arm64: dts: hi6220: add pinctrl for uarts and enable
 them
In-Reply-To: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
References: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1460505352-13157-13-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl for uart2 uart3 and uart4. Enable uart1 uart2 and uart3.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 12 ++++++++++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 3dbf51b..30c92bd 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -53,6 +53,18 @@
 		i2c1: i2c at f7101000 {
 			status = "ok";
 		};
+
+		uart1: uart at f7111000 {
+			status = "ok";
+		};
+
+		uart2: uart at f7112000 {
+			status = "ok";
+		};
+
+		uart3: uart at f7113000 {
+			status = "ok";
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3a665ef..e8bb81f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -266,6 +266,8 @@
 			clocks = <&sys_ctrl HI6220_UART1_PCLK>,
 				 <&sys_ctrl HI6220_UART1_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func1 &uart1_cfg_func2>;
 			status = "disabled";
 		};
 
@@ -276,6 +278,8 @@
 			clocks = <&sys_ctrl HI6220_UART2_PCLK>,
 				 <&sys_ctrl HI6220_UART2_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pmx_func &uart2_cfg_func>;
 			status = "disabled";
 		};
 
@@ -286,6 +290,9 @@
 			clocks = <&sys_ctrl HI6220_UART3_PCLK>,
 				 <&sys_ctrl HI6220_UART3_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart3_pmx_func &uart3_cfg_func>;
+			status = "disabled";
 		};
 
 		uart4: uart at f7114000 {
@@ -295,6 +302,8 @@
 			clocks = <&sys_ctrl HI6220_UART4_PCLK>,
 				 <&sys_ctrl HI6220_UART4_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart4_pmx_func &uart4_cfg_func>;
 			status = "disabled";
 		};
 
-- 
1.9.1
