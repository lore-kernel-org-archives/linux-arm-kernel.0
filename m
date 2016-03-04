From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 4 Mar 2016 14:37:27 +0800
Subject: [PATCH v5 09/17] xen/hvm/params: Add a new delivery type for
 event-channel in HVM_PARAM_CALLBACK_IRQ
In-Reply-To: <1457073455-11516-1-git-send-email-zhaoshenglong@huawei.com>
References: <1457073455-11516-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1457073455-11516-10-git-send-email-zhaoshenglong@huawei.com>
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
 include/xen/interface/hvm/params.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/xen/interface/hvm/params.h b/include/xen/interface/hvm/params.h
index 70ad208..d32b02b 100644
--- a/include/xen/interface/hvm/params.h
+++ b/include/xen/interface/hvm/params.h
@@ -53,6 +53,16 @@
  * if this delivery method is available.
  */
 
+#define HVM_PARAM_CALLBACK_TYPE_EVENT    3
+/*
+ * val[55:16] need to be zero.
+ * val[15:8] is flag of event-channel interrupt:
+ *  bit 8: interrupt is edge(1) or level(0) triggered
+ *  bit 9: interrupt is active low(1) or high(0)
+ * val[7:0] is PPI number used by event-channel.
+ * This is only used by ARM/ARM64.
+ */
+
 #define HVM_PARAM_STORE_PFN    1
 #define HVM_PARAM_STORE_EVTCHN 2
 
-- 
2.0.4
