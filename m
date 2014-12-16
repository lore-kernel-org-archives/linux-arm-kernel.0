From: david.lanzendoerfer@o2s.ch (David =?utf-8?q?Lanzend=C3=B6rfer?=)
Date: Tue, 16 Dec 2014 01:37:51 +0100
Subject: [PATCH 2/4] mmc: sunxi: Correcting SDXC_HARDWARE_RESET bit
In-Reply-To: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
References: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
Message-ID: <20141216003750.15488.23791.stgit@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixing the register name in sunxi_mmc_reset_host since the SDXC_HARDWARE_RESET bit
is actually located within REG_GCTRL and not REG_CMDR as it was pointed out by Allwinner.

Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
Reported-by: ?? <lixiang@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 25ba321..50bd3d2 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -252,7 +252,7 @@ static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
 	unsigned long expire = jiffies + msecs_to_jiffies(250);
 	u32 rval;
 
-	mmc_writel(host, REG_CMDR, SDXC_HARDWARE_RESET);
+	mmc_writel(host, REG_GCTRL, SDXC_HARDWARE_RESET);
 	do {
 		rval = mmc_readl(host, REG_GCTRL);
 	} while (time_before(jiffies, expire) && (rval & SDXC_HARDWARE_RESET));
