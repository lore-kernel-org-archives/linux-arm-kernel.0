From: zhongkaihua@huawei.com (Kaihua Zhong)
Date: Fri, 3 Nov 2017 15:25:05 +0800
Subject: [PATCH 1/3] dt-bindings: clk: Hi3660: Document stub clock
In-Reply-To: <1509693907-90682-1-git-send-email-zhongkaihua@huawei.com>
References: <1509693907-90682-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <1509693907-90682-2-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

Document the DT binding for stub clock which is used for CPU,
GPU and DDR frequency scaling.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/devicetree/bindings/clock/hi3660-clock.txt | 6 ++++++
 1 file changed, 6 insertions(+)

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
 
-- 
1.9.1
