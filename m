From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 11 Jul 2018 00:24:35 +0800
Subject: [RFC PATCH stericsson] mcde_component_drivers[] can be static
In-Reply-To: <201807110005.U4U4ySBV%fengguang.wu@intel.com>
References: <201807110005.U4U4ySBV%fengguang.wu@intel.com>
Message-ID: <20180710162435.GA163985@lkp-ib04>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: ee7f210157e9 ("MCDE hack")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 mcde_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index df46a36..6cfa8db 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -240,7 +240,7 @@ static const struct component_master_ops mcde_drm_comp_ops = {
 	.unbind = mcde_drm_unbind,
 };
 
-struct platform_driver *const mcde_component_drivers[] = {
+static struct platform_driver *const mcde_component_drivers[] = {
 	&mcde_dsi_driver,
 };
 
