From: lkp@intel.com (kbuild test robot)
Date: Sun, 11 Feb 2018 15:54:13 +0800
Subject: [RFC PATCH] mtd: spi-nor: rockchip_sfc_runtime_suspend() can be static
In-Reply-To: <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
References: <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <20180211075413.GA11432@lkp-wsm-ep2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: dbc2d867929a ("mtd: spi-nor: add rockchip serial flash controller driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 rockchip-sfc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/rockchip-sfc.c b/drivers/mtd/spi-nor/rockchip-sfc.c
index 60371011..e38d79d 100644
--- a/drivers/mtd/spi-nor/rockchip-sfc.c
+++ b/drivers/mtd/spi-nor/rockchip-sfc.c
@@ -896,7 +896,7 @@ static int rockchip_sfc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-int rockchip_sfc_runtime_suspend(struct device *dev)
+static int rockchip_sfc_runtime_suspend(struct device *dev)
 {
 	struct rockchip_sfc *sfc = dev_get_drvdata(dev);
 
@@ -904,7 +904,7 @@ int rockchip_sfc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-int rockchip_sfc_runtime_resume(struct device *dev)
+static int rockchip_sfc_runtime_resume(struct device *dev)
 {
 	struct rockchip_sfc *sfc = dev_get_drvdata(dev);
 
