From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 16:12:07 +0530
Subject: [PATCH V2 17/22] watchdog/mpcore_wdt: use correct clk_rate to
 program timeout
In-Reply-To: <4d69b903be5a62ee88aa1017d5dcbf94bbe0dc8e.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
 <4d69b903be5a62ee88aa1017d5dcbf94bbe0dc8e.1331524811.git.viresh.kumar@st.com>
Message-ID: <4F96837F.8030702@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/12/2012 9:52 AM, Viresh KUMAR wrote:
> Currently, mpcore wdt driver doesn't use exact clk_rate to program timeout in
> hardware. This patch provides two ways of doing so:
> 	- either use clk_get_rate() if clk_get passes
> 	- use clk_rate passed via module param
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Wim,

Will these go in v3.5?

Please squash following with this patch while applying.

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 3690af3..e7cadc0 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -370,7 +370,7 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
                        TIMER_MARGIN);
        }
 
-       mpcore_wdt_set_heartbeat(NULL, mpcore_margin);
+       mpcore_wdt_set_heartbeat(&wdt->wdd, mpcore_margin);
        dev_info(wdt->dev, "MPcore Watchdog Timer: 0.1. mpcore_noboot=%d "
                        "mpcore_margin=%d sec (nowayout= %d)\n", mpcore_noboot,
                        mpcore_margin, nowayout);

-- 
viresh
