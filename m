From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 23 Jul 2014 15:02:00 +0200
Subject: [PATCH RFC] arm/mach-imximx/iomux-v3: Do not export symbol without
 public declaration
Message-ID: <1406120520-14390-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both mxc_iomux_v3_setup_pad and mxc_iomux_v3_setup_multiple_pads are
declared in iomux-v3.h which can't be used in any module. None of the
objects in this directory is tristate. Neither can the header be included
in out-of-tree modules.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm/mach-imx/iomux-v3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/iomux-v3.c b/arch/arm/mach-imx/iomux-v3.c
index 9dae74bf47fc..d61f9606fc56 100644
--- a/arch/arm/mach-imx/iomux-v3.c
+++ b/arch/arm/mach-imx/iomux-v3.c
@@ -55,7 +55,6 @@ int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t pad)
 
 	return 0;
 }
-EXPORT_SYMBOL(mxc_iomux_v3_setup_pad);
 
 int mxc_iomux_v3_setup_multiple_pads(iomux_v3_cfg_t *pad_list, unsigned count)
 {
@@ -71,7 +70,6 @@ int mxc_iomux_v3_setup_multiple_pads(iomux_v3_cfg_t *pad_list, unsigned count)
 	}
 	return 0;
 }
-EXPORT_SYMBOL(mxc_iomux_v3_setup_multiple_pads);
 
 void mxc_iomux_v3_init(void __iomem *iomux_v3_base)
 {
-- 
1.8.5.5
