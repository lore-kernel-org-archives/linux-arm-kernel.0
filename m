From: xuyiping@hisilicon.com (Xu YiPing)
Date: Fri, 17 Nov 2017 17:27:30 +0800
Subject: [PATCH v3 1/3] dt-bindings: clk: Hi3660: Document stub clock
In-Reply-To: <1510910852-2175-1-git-send-email-xuyiping@hisilicon.com>
References: <1510910852-2175-1-git-send-email-xuyiping@hisilicon.com>
Message-ID: <1510910852-2175-2-git-send-email-xuyiping@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

Document the DT binding for stub clock which is used for CPU,
GPU and DDR frequency scaling.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/devicetree/bindings/clock/hi3660-clock.txt | 6 ++++++
 include/dt-bindings/clock/hi3660-clock.h                 | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/hi3660-clock.txt b/Documentation/devicetree/bindings/clock/hi3660-clock.txt
index 0035a7e..946da7c 100644
--- a/Documentation/devicetree/bindings/clock/hi3660-clock.txt
+++ b/Documentation/devicetree/bindings/clock/hi3660-clock.txt
@@ -13,12 +13,18 @@ Required Properties:
 	- "hisilicon,hi3660-pmuctrl"
 	- "hisilicon,hi3660-sctrl"
 	- "hisilicon,hi3660-iomcu"
+	- "hisilicon,hi3660-stub-clk"
 
 - reg: physical base address of the controller and length of memory mapped
   region.
 
 - #clock-cells: should be 1.
 
+Optional Properties:
+
+- mboxes: Phandle to the mailbox for sending message to MCU.
+            (See: ../mailbox/hisilicon,hi3660-mailbox.txt for more info)
+
 Each clock is assigned an identifier and client nodes use this identifier
 to specify the clock which they consume.
 
diff --git a/include/dt-bindings/clock/hi3660-clock.h b/include/dt-bindings/clock/hi3660-clock.h
index adb768d..75d583e 100644
--- a/include/dt-bindings/clock/hi3660-clock.h
+++ b/include/dt-bindings/clock/hi3660-clock.h
@@ -208,4 +208,11 @@
 #define HI3660_CLK_I2C6_IOMCU		3
 #define HI3660_CLK_IOMCU_PERI0		4
 
+/* clk in stub clock */
+#define HI3660_CLK_STUB_CLUSTER0	0
+#define HI3660_CLK_STUB_CLUSTER1	1
+#define HI3660_CLK_STUB_GPU		2
+#define HI3660_CLK_STUB_DDR		3
+#define HI3660_CLK_STUB_NUM		4
+
 #endif	/* __DTS_HI3660_CLOCK_H */
-- 
1.9.1
