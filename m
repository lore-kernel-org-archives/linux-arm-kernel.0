From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  1 Mar 2011 21:33:41 +0100
Subject: [PATCH 2/2] ARM: mxc91231/iomux: mark pin_list as const
In-Reply-To: <1299011621-18886-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1299011621-18886-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1299011621-18886-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxc91231/iomux.c                  |    4 ++--
 arch/arm/plat-mxc/include/mach/iomux-mxc91231.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mxc91231/iomux.c b/arch/arm/mach-mxc91231/iomux.c
index 405d9b1..5acb4d0 100644
--- a/arch/arm/mach-mxc91231/iomux.c
+++ b/arch/arm/mach-mxc91231/iomux.c
@@ -134,10 +134,10 @@ int mxc_iomux_alloc_pin(const unsigned int pin_mode, const char *label)
 }
 EXPORT_SYMBOL(mxc_iomux_alloc_pin);
 
-int mxc_iomux_setup_multiple_pins(unsigned int *pin_list, unsigned count,
+int mxc_iomux_setup_multiple_pins(const unsigned int *pin_list, unsigned count,
 		const char *label)
 {
-	unsigned int *p = pin_list;
+	const unsigned int *p = pin_list;
 	int i;
 	int ret = -EINVAL;
 
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h b/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
index 15d5951..a86983d 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
@@ -51,7 +51,7 @@ int mxc_iomux_alloc_pin(const unsigned int pin_mode, const char *label);
  * setups mutliple pins
  * convenient way to call the above function with tables
  */
-int mxc_iomux_setup_multiple_pins(unsigned int *pin_list, unsigned count,
+int mxc_iomux_setup_multiple_pins(const unsigned int *pin_list, unsigned count,
 		const char *label);
 
 /*
-- 
1.7.2.3
