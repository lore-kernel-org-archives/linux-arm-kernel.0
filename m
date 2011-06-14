From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 15 Jun 2011 00:16:13 +0300
Subject: [PATCH 2/3] arm: omap3: cm-t35: fix slow path warning
In-Reply-To: <20110614073648.GI3352@atomide.com>
References: <20110614073648.GI3352@atomide.com>
Message-ID: <1308086174-3080-2-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix warning issued by gpio_set_value() call with TPS gpios.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 6c5881b..256b81c 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -466,9 +466,9 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 	if (gpio_request_one(wlan_rst, GPIOF_OUT_INIT_HIGH, "WLAN RST") == 0) {
 		gpio_export(wlan_rst, 0);
 		udelay(10);
-		gpio_set_value(wlan_rst, 0);
+		gpio_set_value_cansleep(wlan_rst, 0);
 		udelay(10);
-		gpio_set_value(wlan_rst, 1);
+		gpio_set_value_cansleep(wlan_rst, 1);
 	} else {
 		pr_err("CM-T35: could not obtain gpio for WiFi reset\n");
 	}
-- 
1.7.3.4
