From: kslee.adrian@gmail.com (Ks Lee)
Date: Thu, 21 Apr 2011 09:16:55 -0000
Subject: [PATCH] ARM: tegra: Ensure all sched_clock() implementations are
	notrace marked
Message-ID: <BANLkTi=mgQhb8x41zpi93SjbDdELUdSjZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ftrace requires sched_clock() to be notrace.
Ensure that all implementations are so marked.

Signed-off-by: Adrian Lee <kyungsik.lee@lge.com>
---
 arch/arm/mach-tegra/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 0fcb1eb..2f827ff 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -98,7 +98,7 @@ static void tegra_timer_set_mode(enum clock_event_mode
mode,
  }
 }

-static cycle_t tegra_clocksource_read(struct clocksource *cs)
+static cycle_t notrace tegra_clocksource_read(struct clocksource *cs)
 {
  return timer_readl(TIMERUS_CNTR_1US);
 }
-- 
1.7.0.4
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110421/d5dfdfa8/attachment-0001.html>
