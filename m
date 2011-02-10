From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 10 Feb 2011 10:56:21 +0100
Subject: [PATCH] ARM: mx3/mx31_3ds: fix compiler warning without
	CONFIG_USB_ULPI
Message-ID: <1297331781-11551-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:

	arch/arm/mach-mx3/mach-mx31_3ds.c:249: warning: 'mx31_3ds_host2_init' defined but not used

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 63b314c..6d55c62 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -245,7 +245,7 @@ usbotg_free_reset:
 	return err;
 }
 
-static int mx31_3ds_host2_init(struct platform_device *pdev)
+static int __maybe_unused mx31_3ds_host2_init(struct platform_device *pdev)
 {
 	int err;
 
-- 
1.7.2.3
