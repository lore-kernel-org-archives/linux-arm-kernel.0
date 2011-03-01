From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  1 Mar 2011 21:33:40 +0100
Subject: [PATCH 1/2] ARM: iomux-imx31: mark pin_list as const
Message-ID: <1299011621-18886-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following warning in a mx3_defconfig build:

	arch/arm/mach-mx3/mach-bug.c: In function 'bug_board_init':
	arch/arm/mach-mx3/mach-bug.c:47: warning: passing argument 1 of 'mxc_iomux_setup_multiple_pins' discards qualifiers from pointer target type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/iomux-imx31.c            |    4 ++--
 arch/arm/plat-mxc/include/mach/iomux-mx3.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/iomux-imx31.c b/arch/arm/mach-mx3/iomux-imx31.c
index a1d7fa5..525071b 100644
--- a/arch/arm/mach-mx3/iomux-imx31.c
+++ b/arch/arm/mach-mx3/iomux-imx31.c
@@ -118,10 +118,10 @@ int mxc_iomux_alloc_pin(const unsigned int pin, const char *label)
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
 
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
index cbaed29..b07008f 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
@@ -117,7 +117,7 @@ int mxc_iomux_alloc_pin(const unsigned int pin, const char *label);
  * setups mutliple pins
  * convenient way to call the above function with tables
  */
-int mxc_iomux_setup_multiple_pins(unsigned int *pin_list, unsigned count,
+int mxc_iomux_setup_multiple_pins(const unsigned int *pin_list, unsigned count,
 		const char *label);
 
 /*
-- 
1.7.2.3
