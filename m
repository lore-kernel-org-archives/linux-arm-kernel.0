From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Mar 2011 16:53:14 +0000
Subject: [RFC PATCH 08/20] ARM: remove unused twd_timer_setup stub
In-Reply-To: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1299084806-16546-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is no in-tree users of twd_timer_setup() anymore,
remove it completely.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/smp_twd.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 4096736..d2abe52 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -37,11 +37,4 @@ static inline int twd_timer_register_setup(int (*setup)(struct clock_event_devic
 }
 #endif
 
-/*
- * Dummy function, to be removed once there is no in-tree user anymore.
- */
-static inline void twd_timer_setup(void *dummy)
-{
-}
-
 #endif
-- 
1.7.0.4
