From: zonque@gmail.com (Daniel Mack)
Date: Fri, 17 Jun 2011 18:17:12 +0200
Subject: [PATCH] ARM: OMAP: Overo: remove duplicate call to
	overo_ads7846_init()
In-Reply-To: <87r56sbg3b.fsf@ti.com>
References: <87r56sbg3b.fsf@ti.com>
Message-ID: <1308327432-31177-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

overo_ads7846_init() is already called from overo_spi_init(), and
calling it twice is not only unnecessary but causes a warning as
"reg-fixed-voltage.1" is already added to the device tree.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/board-overo.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 175e1ab..110475f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -568,7 +568,6 @@ static void __init overo_init(void)
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	overo_spi_init();
-	overo_ads7846_init();
 	overo_init_smsc911x();
 	overo_display_init();
 	overo_init_led();
-- 
1.7.5.1
