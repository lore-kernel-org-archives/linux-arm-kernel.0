From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 14 Sep 2015 14:42:09 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Remove CONFIG_VMSPLIT_2G
Message-ID: <1442252529-13595-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_VMSPLIT_2G was added to mx5_defconfig by commit 06965c39b4c639
("ARM i.MX5: update defconfig") to fix an issue where mx53 was not
detecting the full 1GiB memory range.

However, as explained by Russell King [1] the correct fix is to select
CONFIG_HIGHMEM.

imx_v6_v7_deconfig inherited such option from mx5_defconfig.

As imx_v6_v7_deconfig has CONFIG_HIGHMEM=y, we should no longer
select such non-standard CONFIG_VMSPLIT_2G option.

[1] http://www.spinics.net/lists/arm-kernel/msg137839.html

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 61d4e02..4187f69 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -47,7 +47,6 @@ CONFIG_SOC_VF610=y
 CONFIG_PCI=y
 CONFIG_PCI_IMX6=y
 CONFIG_SMP=y
-CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-- 
1.9.1
