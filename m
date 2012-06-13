From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 13 Jun 2012 18:13:21 +0100
Subject: [PATCH 1/2] ARM: vexpress: Remove IRQ defines from mach/irq.h
In-Reply-To: <1339607602-3846-1-git-send-email-tixy@linaro.org>
References: <1339607602-3846-1-git-send-email-tixy@linaro.org>
Message-ID: <1339607602-3846-2-git-send-email-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@linaro.org>

The irq numbers are only used in one place so remove these defines
and hardcode the value at the location it is used.

This leaves mach/irq.h only containing NR_IRQ and so it is safe
when it gets dropped from inclusion when SPARSE_IRQ is defined.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 arch/arm/mach-vexpress/include/mach/irqs.h |    3 ---
 arch/arm/mach-vexpress/ct-ca9x4.c          |    2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-vexpress/include/mach/irqs.h b/arch/arm/mach-vexpress/include/mach/irqs.h
index 4b10ee7..e109c66 100644
--- a/arch/arm/mach-vexpress/include/mach/irqs.h
+++ b/arch/arm/mach-vexpress/include/mach/irqs.h
@@ -1,4 +1 @@
-#define IRQ_LOCALTIMER		29
-#define IRQ_LOCALWDOG		30
-
 #define NR_IRQS	256
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index c65cc3b..123d68af 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -45,7 +45,7 @@ static void __init ct_ca9x4_map_io(void)
 }
 
 #ifdef CONFIG_HAVE_ARM_TWD
-static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, A9_MPCORE_TWD, IRQ_LOCALTIMER);
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, A9_MPCORE_TWD, 29);
 
 static void __init ca9x4_twd_init(void)
 {
-- 
1.7.10
