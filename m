From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat, 27 Jun 2015 23:11:44 +0200
Subject: [PATCH] clocksource: imx: define clocksource for mx27
Message-ID: <1435439504-406-1-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocksource imx27 wasn't defined in timer-imx-gpt.c,
so the kernel no longer boot on imx27. Just define
clocksource imx27 as an imx21.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/clocksource/timer-imx-gpt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 879c784..2d59038 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -529,6 +529,7 @@ static void __init imx6dl_timer_init_dt(struct device_node *np)
 
 CLOCKSOURCE_OF_DECLARE(imx1_timer, "fsl,imx1-gpt", imx1_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(imx21_timer, "fsl,imx21-gpt", imx21_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx27_timer, "fsl,imx27-gpt", imx21_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(imx31_timer, "fsl,imx31-gpt", imx31_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(imx25_timer, "fsl,imx25-gpt", imx31_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(imx50_timer, "fsl,imx50-gpt", imx31_timer_init_dt);
-- 
1.7.4.4
