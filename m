From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu,  3 Mar 2011 14:58:32 +0000
Subject: [PATCH 4/7] ARM: S3C64XX: Tone down SDHCI debugging
In-Reply-To: <20110303145710.GA32234@opensource.wolfsonmicro.com>
References: <20110303145710.GA32234@opensource.wolfsonmicro.com>
Message-ID: <1299164315-22246-4-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC core calls s3c6400_setup_sdhcp_cfg_card() very frequently, causing
the log message in there at KERN_INFO to be displayed a lot which is slow
and overly chatty. Convert the message into a pr_debug() to tone this down.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/setup-sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/setup-sdhci.c b/arch/arm/mach-s3c64xx/setup-sdhci.c
index 1a94203..f344a22 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci.c
@@ -56,7 +56,7 @@ void s3c6400_setup_sdhci_cfg_card(struct platform_device *dev,
 	else
 		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
 
-	printk(KERN_INFO "%s: CTRL 2=%08x, 3=%08x\n", __func__, ctrl2, ctrl3);
+	pr_debug("%s: CTRL 2=%08x, 3=%08x\n", __func__, ctrl2, ctrl3);
 	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
 	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
 }
-- 
1.7.2.3
