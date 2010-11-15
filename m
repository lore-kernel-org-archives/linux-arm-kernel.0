From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Nov 2010 17:31:00 +0000
Subject: [PATCH 2/5] ARM: perf: avoid exposing internal stop function for v6
	PMU
In-Reply-To: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
Message-ID: <1289842263-21241-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike other pmu functions, armv6pmu_pmu_stop is not declared static.
This patch adds the missing keyword.

Cc: Jamie Iles <jamie.iles@picochip.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index c49e170..35319b8 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -1121,7 +1121,7 @@ armv6pmu_start(void)
 	spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
-void
+static void
 armv6pmu_stop(void)
 {
 	unsigned long flags, val;
-- 
1.7.0.4
