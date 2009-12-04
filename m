From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri,  4 Dec 2009 16:50:29 +0100
Subject: [PATCH 1/1] mx31moboard: fix usbh device names
In-Reply-To: <20091204122045.GQ15126@pengutronix.de>
References: <20091204122045.GQ15126@pengutronix.de>
Message-ID: <1259941829-22222-1-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mx31moboard-devboard.c |    2 +-
 arch/arm/mach-mx3/mx31moboard-marxbot.c  |    2 +-
 arch/arm/mach-mx3/mx31moboard.c          |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
index 8acf038..f3123f1 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -294,7 +294,7 @@ static int __init marxbot_usbh1_init(void)
 
 	usbh1_pdata.otg = otg;
 
-	return mxc_register_device(&mx31_usbh1, &usbh1_pdata);
+	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
 }
 
 /*
diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mx31moboard.c
index 1ec679a..fab9f3f 100644
--- a/arch/arm/mach-mx3/mx31moboard.c
+++ b/arch/arm/mach-mx3/mx31moboard.c
@@ -392,7 +392,7 @@ static int __init moboard_usbh2_init(void)
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
 
-	return mxc_register_device(&mx31_usbh2, &usbh2_pdata);
+	return mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 }
 
 
-- 
1.6.3.3
