From: marex@denx.de (Marek Vasut)
Date: Mon, 17 Oct 2016 18:34:11 +0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Increase CMA size
Message-ID: <20161017163411.11888-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the CMA size to 64 MiB, otherwise it isn't possible to use
etnaviv driver on systems with 1920x1080 panel due to insufficient
memory .

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8ec4dbb..8e66e22 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -86,6 +86,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_IMX_WEIM=y
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
-- 
2.9.3
