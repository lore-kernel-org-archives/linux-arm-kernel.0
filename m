From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 28 Jan 2010 14:59:27 -0800
Subject: [RFC PATCH 02/12] arm: msm: add oprofile pmu support
Message-ID: <1264719577-5436-3-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add oprofile pmu support for msm.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/oprofile/op_model_v6.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/oprofile/op_model_v6.c b/arch/arm/oprofile/op_model_v6.c
index f7d2ec5..b240adb 100644
--- a/arch/arm/oprofile/op_model_v6.c
+++ b/arch/arm/oprofile/op_model_v6.c
@@ -32,6 +32,8 @@
 static int irqs[] = {
 #ifdef CONFIG_ARCH_OMAP2
 	3,
+#elif defined(CONFIG_ARCH_MSM_ARM11)
+	INT_ARM11_PMU,
 #endif
 #ifdef CONFIG_ARCH_BCMRING
 	IRQ_PMUIRQ, /* for BCMRING, ARM PMU interrupt is 43 */
-- 
1.6.3.3
