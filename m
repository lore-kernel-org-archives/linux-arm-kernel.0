From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 5 Feb 2016 11:05:44 +0800
Subject: [PATCH v4 09/17] xen/hvm/params: Add a new delivery type for
 event-channel in HVM_PARAM_CALLBACK_IRQ
In-Reply-To: <1454641552-12576-1-git-send-email-zhaoshenglong@huawei.com>
References: <1454641552-12576-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1454641552-12576-10-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Add a new delivery type:
val[63:56] == 3: val[15:8] is flag: val[7:0] is a PPI.
To the flag, bit 0 stands the interrupt mode is edge(1) or level(0) and
bit 1 stands the interrupt polarity is active low(1) or high(0).

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 include/xen/interface/hvm/params.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/xen/interface/hvm/params.h b/include/xen/interface/hvm/params.h
index 70ad208..5dd629f 100644
--- a/include/xen/interface/hvm/params.h
+++ b/include/xen/interface/hvm/params.h
@@ -53,6 +53,15 @@
  * if this delivery method is available.
  */
 
+#define HVM_PARAM_CALLBACK_TYPE_EVENT    3
+/*
+ * val[15:8] is flag of event-channel interrupt:
+ *  bit 0: interrupt is edge(1) or level(0) triggered
+ *  bit 1: interrupt is active low(1) or high(0)
+ * val[7:0] is PPI number used by event-channel.
+ * This is only used by ARM/ARM64.
+ */
+
 #define HVM_PARAM_STORE_PFN    1
 #define HVM_PARAM_STORE_EVTCHN 2
 
-- 
2.0.4
