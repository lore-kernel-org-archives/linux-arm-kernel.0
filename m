From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 31 Mar 2011 09:31:19 +0800
Subject: [PATCH] mmc: sdhci: change CONFIG of MMC_SDHCI_TEGRA from 'tristate'
	to 'bool'
In-Reply-To: <1300114465-3769-1-git-send-email-shawn.guo@freescale.com>
References: <1300114465-3769-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1301535079-21714-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

This config option is used to decide whether tegra sdhci support
should be build into the sdhci-platform module.  So setting it 'm'
is nonsense, since we can't build part of an module as a module.
The effect for 'm' will probably be the same as for 'n'.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
The commit message comes from the comment given by Lars-Peter Clausen
on another Naked patch :)

 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 94df405..b981715 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -154,7 +154,7 @@ config MMC_SDHCI_DOVE
 	  If unsure, say N.
 
 config MMC_SDHCI_TEGRA
-	tristate "SDHCI platform support for the Tegra SD/MMC Controller"
+	bool "SDHCI platform support for the Tegra SD/MMC Controller"
 	depends on MMC_SDHCI_PLTFM && ARCH_TEGRA
 	select MMC_SDHCI_IO_ACCESSORS
 	help
-- 
1.7.1
