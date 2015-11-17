From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:56 +0800
Subject: [PATCH v3 57/62] hvm/params: Add a new dilivery type for
 event-channel in HVM_PARAM_CALLBACK_IRQ
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-58-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Add a new dilivery type:
val[63:56] == 3: val[15:8] is flag: val[7:0] is a PPI.
To the flag, bit 0 stands the interrupt mode is edge(1) or level(0) and
bit 1 stands the interrupt polarity is active low(1) or high(0).

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/include/public/hvm/params.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/xen/include/public/hvm/params.h b/xen/include/public/hvm/params.h
index 356dfd3..5aa2aba 100644
--- a/xen/include/public/hvm/params.h
+++ b/xen/include/public/hvm/params.h
@@ -38,6 +38,11 @@
  * val[63:56] == 2: val[7:0] is a vector number, check for
  *                  XENFEAT_hvm_callback_vector to know if this delivery
  *                  method is available.
+ * val[63:56] == 3: val[15:8] is flag of event-channel interrupt:
+ *                      bit 0: interrupt is edge(1) or level(0) triggered
+ *                      bit 1: interrupt is active low(1) or high(0)
+ *                  val[7:0] is PPI number used by event-channel.
+ *                  This is only used by ARM/ARM64.
  * If val == 0 then CPU0 event-channel notifications are not delivered.
  */
 #define HVM_PARAM_CALLBACK_IRQ 0
-- 
2.1.0
