From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 14 Feb 2011 13:36:42 +0300
Subject: [PATCH] tosa-bt: drop setting LED trigger name,
	as it's unsupported now
Message-ID: <1297679802-24669-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 2e48928d8a0f38c1b5c81eb3f1294de8a6382c68 it's no longer possible to set
the name of the LED trigger for RFKILL events. Drop respective code from tosa-bt.c

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>
Cc: John W. Linville <linville@tuxdriver.com>
---
 arch/arm/mach-pxa/tosa-bt.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa-bt.c b/arch/arm/mach-pxa/tosa-bt.c
index c31e601..b9b1e5c 100644
--- a/arch/arm/mach-pxa/tosa-bt.c
+++ b/arch/arm/mach-pxa/tosa-bt.c
@@ -81,8 +81,6 @@ static int tosa_bt_probe(struct platform_device *dev)
 		goto err_rfk_alloc;
 	}
 
-	rfkill_set_led_trigger_name(rfk, "tosa-bt");
-
 	rc = rfkill_register(rfk);
 	if (rc)
 		goto err_rfkill;
-- 
1.7.2.3
