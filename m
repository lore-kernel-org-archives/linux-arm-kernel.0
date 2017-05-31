From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 May 2017 11:49:15 +0200
Subject: [PATCH 2/2] power: reset: at91-sama5d2_shdwc: fix clobber list
In-Reply-To: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
References: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170531094915.3469-2-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assembly in at91_lpddr_poweroff has r0 in the clobber list but uses r6.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 90b0b5a70ce5..55fce8b75245 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -132,7 +132,7 @@ static void at91_lpddr_poweroff(void)
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
 		  "r" (at91_shdwc->at91_shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
-		: "r0");
+		: "r6");
 }
 
 static u32 at91_shdwc_debouncer_value(struct platform_device *pdev,
-- 
2.11.0
