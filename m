From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 12 Jan 2013 19:50:04 +0800
Subject: [PATCH v2 1/3] clockevents: export clockevents_config_and_register
 for module use
In-Reply-To: <1357991406-22778-1-git-send-email-shawn.guo@linaro.org>
References: <1357991406-22778-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1357991406-22778-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clockevents_config_and_register is a handy helper for clockevent
drivers, some of which might support module build, so export the symbol.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/clockevents.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 30b6de0..c6d6400 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -339,6 +339,7 @@ void clockevents_config_and_register(struct clock_event_device *dev,
 	clockevents_config(dev, freq);
 	clockevents_register_device(dev);
 }
+EXPORT_SYMBOL_GPL(clockevents_config_and_register);
 
 /**
  * clockevents_update_freq - Update frequency and reprogram a clock event device.
-- 
1.7.9.5
