From: olof@lixom.net (Olof Johansson)
Date: Thu,  6 Oct 2011 19:54:21 -0700
Subject: [PATCH 11/14] ARM: tegra: tegra_rtc_read_ms should be static
In-Reply-To: <1317956064-17650-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
Message-ID: <1317956064-17650-12-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not exported and not used externally

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 4d6759a..e2272d2 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -133,7 +133,7 @@ static void notrace tegra_update_sched_clock(void)
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
-u64 tegra_rtc_read_ms(void)
+static u64 tegra_rtc_read_ms(void)
 {
 	u32 ms = readl(rtc_base + RTC_MILLISECONDS);
 	u32 s = readl(rtc_base + RTC_SHADOW_SECONDS);
-- 
1.7.4.1
