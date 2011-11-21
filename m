From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Mon, 21 Nov 2011 09:53:03 +0530
Subject: [PATCH 1/4] mmc: sdhci-pxa: Trivial fix in Kconfig
In-Reply-To: <87r51fwxgt.fsf@laptop.org>
References: <87r51fwxgt.fsf@laptop.org>
Message-ID: <1321849383-2772-1-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select MMC_SDHCI_PXAV3 by default if CPU is MMP2
Select MMC_SDHCI_PXAV2 by default if CPU is PXA910

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Reviewed-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index cf444b0..21b4149 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -186,7 +186,7 @@ config MMC_SDHCI_PXAV3
 	depends on CLKDEV_LOOKUP
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
-	default CPU_MMP2
+	default y if CPU_MMP2
 	help
 	  This selects the Marvell(R) PXAV3 SD Host Controller.
 	  If you have a MMP2 platform with SD Host Controller
@@ -199,7 +199,7 @@ config MMC_SDHCI_PXAV2
 	depends on CLKDEV_LOOKUP
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
-	default CPU_PXA910
+	default y if CPU_PXA910
 	help
 	  This selects the Marvell(R) PXAV2 SD Host Controller.
 	  If you have a PXA9XX platform with SD Host Controller
-- 
1.7.0.4
