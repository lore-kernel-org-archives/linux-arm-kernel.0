From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Wed,  7 Dec 2011 21:56:56 +0200
Subject: [PATCH] omap: rx51: initialize isp1704 properly
In-Reply-To: <20111207193141.GG31337@atomide.com>
References: <20111207193141.GG31337@atomide.com>
Message-ID: <1323287816-2809-1-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heikki Krogerus <krohei@gmail.com>

Without this USB networking doesn't work as the link is never detected.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index a1d0257..faac1fc 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -193,7 +193,7 @@ static struct platform_device rx51_charger_device = {
 static void __init rx51_charger_init(void)
 {
 	WARN_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
-		GPIOF_OUT_INIT_LOW, "isp1704_reset"));
+		GPIOF_OUT_INIT_HIGH, "isp1704_reset"));
 
 	platform_device_register(&rx51_charger_device);
 }
-- 
1.7.8.rc1.14.g248db
