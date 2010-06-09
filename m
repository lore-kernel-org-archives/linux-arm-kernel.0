From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 09 Jun 2010 11:39:38 +0200
Subject: [PATCH] SDHCI-S3C fixes and enhancements (driver specific code)
Message-ID: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series includes various fixes to sdhci-s3c driver as well as a
major feature enhancement. This patch series is prepared to get complete
sdhci support on Samsung Aquila board.

A quick overview on the patches:

#1 - enable sdhci-s3c driver on all Samsung platforms
#2 - add missing sdhci_s3c_driver_remove() function
#3 - use sdhci quirk to increase the transaction timeout (let me know if
     this can break any exitsting code)
#4 - introduce new sdhci quirk to get rid of anoying runtime warning and
     possible problems with slow mmc/sd cards
#5 - add support for various methods of notifying the host driver about
     the card insertion/removal (should be compatible with existing code)

Last patch requires changes to the Samsung platform setup code, which
has been posted in a separate patch series for easier merging, please
refer to the "[PATCH] SDHCI-S3C fixes and enhancements (platform
specific code)" thread.

A complete list of patches:

[PATCH 1/5] sdhci-s3c: depend on plat-samsung
[PATCH 2/5] sdhci-s3c: add missing remove function
[PATCH 3/5] sdhci-s3c: increase the timeout value
[PATCH 4/5] sdhci-s3c: add support for the non standard minimal clock value
[PATCH 5/5] sdhci-s3c: add support for new card detection methods

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
