From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 Jul 2010 21:43:45 +0900
Subject: [PATCH v4 0/3] Add support WP on SMDKV210 and SDHCI_QUIRK_NO_WP_BIT
	quirk
Message-ID: <1280234628-27303-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support SDMMC write protection pin on SMDKV210.

Changes since v3:
Addressed comments from Kyungmin Park and Marek Szyprowski

- Added pdata 'bool has_gpio_wp' as per Marek
- Moved new WP quirk checking as per Kyungmin

Changes since v2:
Addressed comments from Marek Szyprowski

- modified wp_gpio checking method for support gpio number 0.
- removed unnecessary checking in dev-hsmmc.c

Changes since v1:
Addressed comments from Ben Dooks, Maurus Cuelenaere and Kyungmin Park

- just pass gpio numbers for support WP as Ben's suggestion
- use the gpio layer for specific machine
- use s3c_sdhcix_set_platdata() in machine_init()
- removed unnecessary EXPORT_SYMBOL

Note: Depends on following patch set

[PATCH v2 1/2] ARM: SAMSUNG: Add device definition for HSMMC3
[PATCH v2 2/2] ARM: S5PV210: Add support HSMMC on SMDKV210
[PATCH v4] Samsung: add new card detection methods in s3c-sdhci driver (platform part) from Marek Szyprowski 
[PATCH v4] sdhci-s3c: add support for new card detection methods (driver part) from Marek Szyprowski 

And this patch set includes the following patches:
