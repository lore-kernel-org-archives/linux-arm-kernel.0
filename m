From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:57:09 +0800
Subject: [PATCH 11/13] xen/hvm/params: Add a new dilivery type for
 event-channel in HVM_PARAM_CALLBACK_IRQ
In-Reply-To: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447754231-7772-12-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Add a new dilivery type:
val[63:56] == 3: val[15:8] is flag: val[7:0] is a PPI.
To the flag, bit 0 stands the interrupt mode is edge(1) or level(0) and
bit 1 stands the interrupt polarity is active low(1) or high(0).

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 include/xen/interface/hvm/params.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/xen/interface/hvm/params.h b/include/xen/interface/hvm/params.h
index a6c7991..550688a 100644
--- a/include/xen/interface/hvm/params.h
+++ b/include/xen/interface/hvm/params.h
@@ -34,6 +34,11 @@
  *                  Domain = val[47:32], Bus  = val[31:16],
  *                  DevFn  = val[15: 8], IntX = val[ 1: 0]
  * val[63:56] == 2: val[7:0] is a vector number.
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
