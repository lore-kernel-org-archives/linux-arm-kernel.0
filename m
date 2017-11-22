From: Bharat.Bhushan@nxp.com (Bharat Bhushan)
Date: Wed, 22 Nov 2017 13:18:43 +0530
Subject: [PATCH v3] staging: fsl-mc: use 32bits to support 64K size mc-portals
Message-ID: <1511336923-610-1-git-send-email-Bharat.Bhushan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per APIs each mc-portal is of 64K size while currently
16bits (type u16) is used to store size of mc-portal.
In these cases upper bit of portal size gets truncated.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
v2->v3:
 - v2 patch: https://patchwork.kernel.org/patch/10067661/
 - Changes patch subject and description

v1->v2:
 - v1 patch: https://patchwork.kernel.org/patch/10067657/
 - replace uin32_t to u32 in patch subject/description

 drivers/staging/fsl-mc/include/mc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/include/mc.h b/drivers/staging/fsl-mc/include/mc.h
index aafe63a..2cf15b0 100644
--- a/drivers/staging/fsl-mc/include/mc.h
+++ b/drivers/staging/fsl-mc/include/mc.h
@@ -325,7 +325,7 @@ static inline void mc_cmd_read_api_version(struct mc_command *cmd,
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
