From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 22 Jun 2012 19:18:05 +0530
Subject: [PATCH 06/11] gpio/omap: add clk_prepare and clk_unprepare
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Message-ID: <1340372890-10091-7-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
for omap gpio debounce clock.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/gpio/gpio-omap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c4ed172..6a73b01 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -893,6 +893,8 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
 		bank->dbck = clk_get(bank->dev, "dbclk");
 		if (IS_ERR(bank->dbck))
 			dev_err(bank->dev, "Could not get gpio dbck\n");
+		else
+			clk_prepare(bank->dbck);
 	}
 
 	spin_lock_irqsave(&bank->lock, flags);
-- 
1.7.1
