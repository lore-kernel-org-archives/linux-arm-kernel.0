From: opendmb@gmail.com (Doug Berger)
Date: Tue, 24 Oct 2017 12:54:49 -0700
Subject: [PATCH v2 5/7] gpio: brcmstb: correct the configuration of level
 interrupts
In-Reply-To: <20171024195451.30535-1-opendmb@gmail.com>
References: <20171024195451.30535-1-opendmb@gmail.com>
Message-ID: <20171024195451.30535-6-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit corrects a bug when configuring the GPIO hardware for
IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_LEVEL_HIGH interrupt types. The
hardware is now correctly configured to support those types.

Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 513de4936a25..183863902f7f 100644
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
