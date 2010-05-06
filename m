From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:23:55 -0700
Subject: [PATCH 04/34] davinci: da830/omap-l137 evm: use 8-wire MMC/SD card
	support
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-5-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Bhandari <vipin.bhandari@ti.com>

The merge for 2.6.34 brings in 8-bit support to the DaVinci MMC/SD driver.

This patch updates the platform data for DA830/OMAP-L137 EVM to use 8-wire
support available in the driver.

Signed-off-by: Vipin Bhandari <vipin.bhandari@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 8e67037..ea293b8 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -244,7 +244,7 @@ static int da830_evm_mmc_get_cd(int index)
 static struct davinci_mmc_config da830_evm_mmc_config = {
 	.get_ro			= da830_evm_mmc_get_ro,
 	.get_cd			= da830_evm_mmc_get_cd,
-	.wires			= 4,
+	.wires			= 8,
 	.max_freq		= 50000000,
 	.caps			= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
 	.version		= MMC_CTLR_VERSION_2,
-- 
1.7.0.2
