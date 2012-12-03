From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 3 Dec 2012 15:54:40 -0200
Subject: [PATCH] ARM: mxs_defconfig: Fix MTD_M25P80 selection
Message-ID: <1354557281-23760-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 8f9d87a0 (ARM: mxs_defconfig: Add SPI and LRADC support) missed the
'=y' annotation to CONFIG_MTD_M25P80.

Fix it, so that SPI Flash can be probed.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 7bf5351..60de31c 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -55,7 +55,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_DATAFLASH=y
-CONFIG_MTD_M25P80
+CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_NETDEVICES=y
-- 
1.7.9.5
