From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:24 +0900
Subject: [PATCH 12/14] ARM: shmobile: rcar-gen2: correct return value of
 shmobile_smp_apmu_suspend_init
In-Reply-To: <cover.1403681315.git.horms+renesas@verge.net.au>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
Message-ID: <ecdaca48629bd99609fdc612685363330967dce2.1403681315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dummy shmobile_smp_apmu_suspend_init() function provided when
CPU_IDLE is not set should not return a value as per the signature
of the function.

This problem appears to have been introduced by
867ba81f728f1daa ("ARM: shmobile: APMU: Add Core-Standby-state for Suspend
to RAM").

Cc: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 8f0cd57..1e81199 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -38,7 +38,7 @@ int shmobile_suspend_init(void);
 void shmobile_smp_apmu_suspend_init(void);
 #else
 static inline int shmobile_suspend_init(void) { return 0; }
-static inline void shmobile_smp_apmu_suspend_init(void) { return 0; }
+static inline void shmobile_smp_apmu_suspend_init(void) { }
 #endif
 
 #ifdef CONFIG_CPU_IDLE
-- 
2.0.0.rc2
