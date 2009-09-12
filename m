From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sat, 12 Sep 2009 18:04:55 +0200
Subject: [PATCH 2/8] s3c6410: sdhci: Adding additional data in sdhci
	platform data structure.
Message-ID: <4AABC6A7.6050707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this breaks hsmmc1 (and hsmmc2).

Attached patch fixes hsmmc1.

Regards,
Maurus Cuelenaere

 From a743b9c3b7a6b63e2c0ccf22a45a06952920dff4 Mon Sep 17 00:00:00 2001
From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Sat, 12 Sep 2009 17:40:33 +0200

This patch adds additional information about the parent clock
name, sdhci clock name and desired sdhci operating frequency
for hsmmc1 (based on e52782df345ec3e826701438ef42d2a8425bb973).

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
  arch/arm/plat-s3c/dev-hsmmc1.c |    3 +++
  1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c/dev-hsmmc1.c b/arch/arm/plat-s3c/dev-hsmmc1.c
index e49bc4c..d8c8f61 100644
--- a/arch/arm/plat-s3c/dev-hsmmc1.c
+++ b/arch/arm/plat-s3c/dev-hsmmc1.c
@@ -41,6 +41,9 @@ struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata = {
      .max_width    = 4,
      .host_caps    = (MMC_CAP_4_BIT_DATA |
                 MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+    .clk_parent_name    = "dout_mpll",
+    .clk_source_name     = "mmc_bus",
+    .clk_speed        = 50*MHZ,
  };

  struct platform_device s3c_device_hsmmc1 = {
-- 
1.6.3.3
