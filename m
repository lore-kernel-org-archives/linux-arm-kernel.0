From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:21 +0200
Subject: [PATCH 41/71] clocksource: sh_mtu2: Constify name argument to
 sh_mtu2_register()
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-41-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The name argument is assigned to const structure fields only, constify
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Wolfram Sang <wsa@sang-engineering.com>
---
 drivers/clocksource/sh_mtu2.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 8fd7059..2fe3ab4c 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -236,7 +236,7 @@ static void sh_mtu2_clock_event_resume(struct clock_event_device *ced)
 }
 
 static void sh_mtu2_register_clockevent(struct sh_mtu2_channel *ch,
-				       char *name, unsigned long rating)
+					const char *name, unsigned long rating)
 {
 	struct clock_event_device *ced = &ch->ced;
 	int ret;
@@ -264,7 +264,7 @@ static void sh_mtu2_register_clockevent(struct sh_mtu2_channel *ch,
 	}
 }
 
-static int sh_mtu2_register(struct sh_mtu2_channel *ch, char *name,
+static int sh_mtu2_register(struct sh_mtu2_channel *ch, const char *name,
 			    unsigned long clockevent_rating)
 {
 	if (clockevent_rating)
@@ -287,7 +287,7 @@ static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch,
 		return ch->irq;
 	}
 
-	return sh_mtu2_register(ch, (char *)dev_name(&mtu->pdev->dev),
+	return sh_mtu2_register(ch, dev_name(&mtu->pdev->dev),
 				cfg->clockevent_rating);
 }
 
-- 
1.7.9.5
