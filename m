From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 22 Nov 2016 15:49:19 +0800
Subject: [PATCH 4/6] dt-bindings: change hi6220-reset.txt according to
 reset-hi6220.c
In-Reply-To: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1479800961-6249-5-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../devicetree/bindings/reset/hisilicon,hi6220-reset.txt   | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
index c25da39..6a864f3 100644
--- a/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
@@ -9,10 +9,9 @@ hi6220 SoC.
 
 Required properties:
 - compatible: should be one of the following:
-  - "hisilicon,hi6220-sysctrl", "syscon" : For peripheral reset controller.
-  - "hisilicon,hi6220-mediactrl", "syscon" : For media reset controller.
-- reg: should be register base and length as documented in the
-  datasheet
+  - "hisilicon,hi6220-reset-sysctrl" : For peripheral reset controller.
+  - "hisilicon,hi6220-reset-mediactrl" : For media reset controller.
+- hisi,rst-syscon: phandle of the reset's syscon.
 - #reset-cells: 1, see below
 
 Example:
@@ -20,7 +19,12 @@ sys_ctrl: sys_ctrl at f7030000 {
 	compatible = "hisilicon,hi6220-sysctrl", "syscon";
 	reg = <0x0 0xf7030000 0x0 0x2000>;
 	#clock-cells = <1>;
+};
+
+sys_ctrl_rst: sys_rst_controller {
+	compatible = "hisilicon,hi6220-reset-sysctrl";
 	#reset-cells = <1>;
+	hisi,rst-syscon = <&sys_ctrl>;
 };
 
 Specifying reset lines connected to IP modules
@@ -29,7 +33,7 @@ example:
 
         uart1: serial at ..... {
                 ...
-                resets = <&sys_ctrl PERIPH_RSTEN3_UART1>;
+                resets = <&sys_ctrl_rst PERIPH_RSTEN3_UART1>;
                 ...
         };
 
-- 
2.7.4
