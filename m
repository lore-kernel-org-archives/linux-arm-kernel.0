From: Bharat.Bhushan@nxp.com (Bharat Bhushan)
Date: Tue, 21 Nov 2017 10:35:23 +0530
Subject: [PATCH v2] staging: fsl-mc: fix mc-portal to use u32 type
Message-ID: <1511240723-24829-1-git-send-email-Bharat.Bhushan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to MC APIs, size of mc-portal in 32bit.
Also fsl_create_mc_io() storing 32 bit mc-portal size.
   " mc_io->portal_size = mc_portal_size;"
   While "mc_io->portal_size" is u16 type and
   "mc_portal_size" is u32 type.

This patches changes mc_io->portal_size from u16 to u32

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 drivers/staging/fsl-mc/include/mc-sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/include/mc-sys.h b/drivers/staging/fsl-mc/include/mc-sys.h
index dca7f90..11d4367 100644
--- a/drivers/staging/fsl-mc/include/mc-sys.h
+++ b/drivers/staging/fsl-mc/include/mc-sys.h
@@ -75,7 +75,7 @@
 struct fsl_mc_io {
 	struct device *dev;
 	u16 flags;
-	u16 portal_size;
+	u32 portal_size;
 	phys_addr_t portal_phys_addr;
 	void __iomem *portal_virt_addr;
 	struct fsl_mc_device *dpmcp_dev;
-- 
1.9.3
