From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:24:29 +0200
Subject: [PATCH 2/5] rtc: at91sam9: remove useless check
In-Reply-To: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438215872-27794-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc->sclk necessarily points to a valid clocks at this point. Else the
probe would have aborted.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 152cd816cc43..0a8485ac3864 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -494,8 +494,7 @@ static int at91_rtc_remove(struct platform_device *pdev)
 	/* disable all interrupts */
 	rtt_writel(rtc, MR, mr & ~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN));
 
-	if (!IS_ERR(rtc->sclk))
-		clk_disable_unprepare(rtc->sclk);
+	clk_disable_unprepare(rtc->sclk);
 
 	return 0;
 }
-- 
2.1.4
