From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 00:51:21 +0200
Subject: [patch-v2.6.33-rc2+ 01/12] arm: omap: musb: ioremap only what's ours
In-Reply-To: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Message-ID: <1262127092-14878-2-git-send-email-felipe.balbi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap3430 TRM says the OTG address space is 4k, not 8k.

Cc: linux-usb at vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a80441d..ba71f76 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -152,7 +152,7 @@ void __init usb_musb_init(void)
 		musb_resources[0].start = OMAP243X_HS_BASE;
 	else
 		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
-	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
+	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
 
 	/*
 	 * REVISIT: This line can be removed once all the platforms using
-- 
1.6.6.35.g1d85d
