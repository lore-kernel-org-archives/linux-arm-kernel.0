From: leo.yan@linaro.org (Leo Yan)
Date: Tue,  4 Aug 2015 15:27:27 +0800
Subject: [PATCH v4 2/4] dt-bindings: clk: Hi6220: Document stub clock driver
In-Reply-To: <1438673249-6051-1-git-send-email-leo.yan@linaro.org>
References: <1438673249-6051-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1438673249-6051-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the new compatible for stub clock driver which is used for CPU
and DDR's dynamic frequency scaling.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../devicetree/bindings/clock/hi6220-clock.txt        | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/hi6220-clock.txt b/Documentation/devicetree/bindings/clock/hi6220-clock.txt
index 259e30a..e4d5fea 100644
--- a/Documentation/devicetree/bindings/clock/hi6220-clock.txt
+++ b/Documentation/devicetree/bindings/clock/hi6220-clock.txt
@@ -15,19 +15,36 @@ Required Properties:
 	- "hisilicon,hi6220-sysctrl"
 	- "hisilicon,hi6220-mediactrl"
 	- "hisilicon,hi6220-pmctrl"
+	- "hisilicon,hi6220-stub-clk"
 
 - reg: physical base address of the controller and length of memory mapped
   region.
 
 - #clock-cells: should be 1.
 
-For example:
+Optional Properties:
+
+- hisilicon,hi6220-clk-sram: phandle to the syscon managing the SoC internal sram;
+  the driver need use the sram to pass parameters for frequency change.
+
+- mboxes: use the label reference for the mailbox as the first parameter, the
+  second parameter is the channel number.
+
+Example 1:
 	sys_ctrl: sys_ctrl at f7030000 {
 		compatible = "hisilicon,hi6220-sysctrl", "syscon";
 		reg = <0x0 0xf7030000 0x0 0x2000>;
 		#clock-cells = <1>;
 	};
 
+Example 2:
+	stub_clock: stub_clock {
+		compatible = "hisilicon,hi6220-stub-clk";
+		hisilicon,hi6220-clk-sram = <&sram>;
+		#clock-cells = <1>;
+		mboxes = <&mailbox 1>;
+	};
+
 Each clock is assigned an identifier and client nodes use this identifier
 to specify the clock which they consume.
 
-- 
1.9.1
