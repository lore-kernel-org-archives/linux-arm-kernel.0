From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 19 Dec 2009 21:18:40 +0100
Subject: [PATCH 1/2] imx/mx3: fix FTBFS for undefined symbols mx31_usbh1 and
	mx31_usbh2
Message-ID: <1261253921-29125-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the symbols mxc_usbh1 and mxc_usbh2 introduced in

	c13a482 (MX3: Add USB platform devices and resources)

instead.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/mach-mx31moboard.c     |    2 +-
 arch/arm/mach-mx3/mx31moboard-devboard.c |    2 +-
 arch/arm/mach-mx3/mx31moboard-marxbot.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index be7d277..949b4de 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -392,7 +392,7 @@ static int __init moboard_usbh2_init(void)
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
 
-	return mxc_register_device(&mx31_usbh2, &usbh2_pdata);
+	return mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 }
 
 
diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
index 8fc624f..438428e 100644
--- a/arch/arm/mach-mx3/mx31moboard-devboard.c
+++ b/arch/arm/mach-mx3/mx31moboard-devboard.c
@@ -179,7 +179,7 @@ static int __init devboard_usbh1_init(void)
 
 	usbh1_pdata.otg = otg;
 
-	return mxc_register_device(&mx31_usbh1, &usbh1_pdata);
+	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
 }
 
 /*
diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 85184a3..1f44b9c 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -294,7 +294,7 @@ static int __init marxbot_usbh1_init(void)
 
 	usbh1_pdata.otg = otg;
 
-	return mxc_register_device(&mx31_usbh1, &usbh1_pdata);
+	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
 }
 
 /*
-- 
1.6.5.2
