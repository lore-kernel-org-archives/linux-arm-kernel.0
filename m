From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 3 Nov 2015 22:28:36 +0800
Subject: [PATCH v2 2/3] ARM: arch_timer: set the arch_delay_timer rating as 400
In-Reply-To: <1446560917-6318-1-git-send-email-jszhang@marvell.com>
References: <1446560917-6318-1-git-send-email-jszhang@marvell.com>
Message-ID: <1446560917-6318-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the arch_delay_timer rating as the same value used in
arch_timer clocksource. This is to help register_current_timer_delay()
to choose the best delay timer during several possible delay timers.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/arch_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 1791f12..db5f556 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -28,6 +28,7 @@ static void __init arch_timer_delay_timer_register(void)
 	/* Use the architected timer for the delay loop. */
 	arch_delay_timer.read_current_timer = arch_timer_read_counter_long;
 	arch_delay_timer.freq = arch_timer_get_rate();
+	arch_delay_timer.rating = 400;
 	register_current_timer_delay(&arch_delay_timer);
 }
 
-- 
2.6.2
