From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Mar 2015 22:17:11 +0200
Subject: [PATCH 09/11] clocksource: tegra: Maintain CPU endianness
In-Reply-To: <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
References: <5519AEB2.8050306@linaro.org>
 <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1427746633-9137-9-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dmitry Osipenko <digetx@gmail.com>

Support big-endian kernel by using endian-aware register access functions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clocksource/tegra20_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index d2616ef..d8a3a4e 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -57,9 +57,9 @@ static u64 persistent_ms, last_persistent_ms;
 static struct delay_timer tegra_delay_timer;
 
 #define timer_writel(value, reg) \
-	__raw_writel(value, timer_reg_base + (reg))
+	writel_relaxed(value, timer_reg_base + (reg))
 #define timer_readl(reg) \
-	__raw_readl(timer_reg_base + (reg))
+	readl_relaxed(timer_reg_base + (reg))
 
 static int tegra_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
-- 
1.9.1
