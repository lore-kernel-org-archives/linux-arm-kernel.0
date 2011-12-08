From: felipe.contreras@nokia.com (Felipe Contreras)
Date: Thu,  8 Dec 2011 22:23:00 +0200
Subject: [PATCH v2] omap: rx51: fix USB
In-Reply-To: <20111208144044.GA25415@xps8300>
References: <20111208144044.GA25415@xps8300>
Message-ID: <1323375780-13190-1-git-send-email-felipe.contreras@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Contreras <felipe.contreras@gmail.com>

The transceiver should be powered on by default, otherwise USB doesn't
work at all.

All kernels after v3.0 are affected.

Cc: stable at kernel.org
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ba1aa07..c15c5c9 100644
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
1.7.8.rc3.17.gf56ef1
