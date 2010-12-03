From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:19:16 +0000
Subject: [PATCH 01/22] ARM: remove obsolete smp_cross_call_done()
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POc68-0007r3-1F@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

smp_cross_call_done() was removed long ago (see 78d236c - remove useless
smp_cross_call_done()).  Remove those which have been subsequently
merged.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-tegra/include/mach/smp.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/smp.h b/arch/arm/mach-tegra/include/mach/smp.h
index e4a34a3..d3cd265 100644
--- a/arch/arm/mach-tegra/include/mach/smp.h
+++ b/arch/arm/mach-tegra/include/mach/smp.h
@@ -12,11 +12,4 @@ static inline void smp_cross_call(const struct cpumask *mask)
 	gic_raise_softirq(mask, 1);
 }
 
-/*
- * Do nothing on MPcore.
- */
-static inline void smp_cross_call_done(cpumask_t callmap)
-{
-}
-
 #endif
-- 
1.6.2.5
