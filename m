From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Nov 2010 17:58:04 +0000
Subject: [PATCH 1/9] ARM: remove obsolete smp_cross_call_done()
In-Reply-To: <20101115175553.GC31421@n2100.arm.linux.org.uk>
References: <20101115175553.GC31421@n2100.arm.linux.org.uk>
Message-ID: <E1PI3Jc-00029W-Aj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

smp_cross_call_done() was removed long ago (see 78d236c - remove useless
smp_cross_call_done()).  Remove those which have been subsequently
merged.

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
