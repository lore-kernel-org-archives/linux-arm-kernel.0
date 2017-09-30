From: opendmb@gmail.com (Doug Berger)
Date: Fri, 29 Sep 2017 20:40:54 -0700
Subject: [PATCH 4/7] gpio: brcmstb: correct the configuration of level
 interrupts
In-Reply-To: <20170930034057.15166-1-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
Message-ID: <20170930034057.15166-5-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit corrects a bug when configuring the GPIO hardware for
IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_LEVEL_HIGH interrupt types. The
hardware is now correctly configured to support those types.

Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index c186141927bb..0418cb266586 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -137,13 +137,13 @@ static int brcmstb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 
 	switch (type) {
 	case IRQ_TYPE_LEVEL_LOW:
-		level = 0;
+		level = mask;
 		edge_config = 0;
 		edge_insensitive = 0;
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
 		level = mask;
-		edge_config = 0;
+		edge_config = mask;
 		edge_insensitive = 0;
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-- 
2.14.1
