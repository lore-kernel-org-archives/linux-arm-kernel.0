From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 7 Mar 2012 15:57:43 +0530
Subject: [PATCH 02/15] watchdog/mpcore_wdt: Add blank line after variable
 definitions in routines
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
Message-ID: <0ba386ae73e8f716fbc2c9aae35ced5ab93a293a.1331115752.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds blank line between local variable definitions and normal code
inside routine to make code more clean.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 64041ac..25f6e4a 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -399,6 +399,7 @@ static int __devexit mpcore_wdt_remove(struct platform_device *dev)
 static int mpcore_wdt_suspend(struct platform_device *dev, pm_message_t msg)
 {
 	struct mpcore_wdt *wdt = platform_get_drvdata(dev);
+
 	mpcore_wdt_stop(wdt);		/* Turn the WDT off */
 	return 0;
 }
@@ -406,6 +407,7 @@ static int mpcore_wdt_suspend(struct platform_device *dev, pm_message_t msg)
 static int mpcore_wdt_resume(struct platform_device *dev)
 {
 	struct mpcore_wdt *wdt = platform_get_drvdata(dev);
+
 	/* re-activate timer */
 	if (test_bit(0, &wdt->timer_alive))
 		mpcore_wdt_start(wdt);
-- 
1.7.8.110.g4cb5d
