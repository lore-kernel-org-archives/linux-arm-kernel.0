From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 29 Apr 2010 10:03:20 +0200
Subject: [PATCH 4/6] arm/mach-mx2: add watchdog device to Phytec-boards
In-Reply-To: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1272528202-24159-5-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/mach-pca100.c |    1 +
 arch/arm/mach-mx2/mach-pcm038.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index 778fff2..a87422e 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -145,6 +145,7 @@ static struct mxc_nand_platform_data pca100_nand_board_info = {
 static struct platform_device *platform_devices[] __initdata = {
 	&mxc_w1_master_device,
 	&mxc_fec_device,
+	&mxc_wdt,
 };
 
 static struct imxi2c_platform_data pca100_i2c_1_data = {
diff --git a/arch/arm/mach-mx2/mach-pcm038.c b/arch/arm/mach-mx2/mach-pcm038.c
index 035fbe0..36c8943 100644
--- a/arch/arm/mach-mx2/mach-pcm038.c
+++ b/arch/arm/mach-mx2/mach-pcm038.c
@@ -182,6 +182,7 @@ static struct platform_device *platform_devices[] __initdata = {
 	&mxc_w1_master_device,
 	&mxc_fec_device,
 	&pcm038_sram_mtd_device,
+	&mxc_wdt,
 };
 
 /* On pcm038 there's a sram attached to CS1, we enable the chipselect here and
-- 
1.7.0
