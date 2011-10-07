From: olof@lixom.net (Olof Johansson)
Date: Thu,  6 Oct 2011 19:54:14 -0700
Subject: [PATCH 04/14] ARM: tegra: timer: don't cast __iomem pointers
In-Reply-To: <1317956064-17650-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
Message-ID: <1317956064-17650-5-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes a lot of:

arch/arm/mach-tegra/timer.c:75:2: warning: cast removes address space of expression
arch/arm/mach-tegra/timer.c:75:2: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-tegra/timer.c:75:2:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-tegra/timer.c:75:2:    got unsigned int
arch/arm/mach-tegra/timer.c:75:2: warning: cast removes address space of expression

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/timer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 9035042..4d6759a 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -62,9 +62,9 @@ static struct timespec persistent_ts;
 static u64 persistent_ms, last_persistent_ms;
 
 #define timer_writel(value, reg) \
-	__raw_writel(value, (u32)timer_reg_base + (reg))
+	__raw_writel(value, timer_reg_base + (reg))
 #define timer_readl(reg) \
-	__raw_readl((u32)timer_reg_base + (reg))
+	__raw_readl(timer_reg_base + (reg))
 
 static int tegra_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
-- 
1.7.4.1
