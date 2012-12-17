From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 17 Dec 2012 21:53:29 +0200
Subject: [PATCH] ARM: OMAP4: PRM: Correct wrong instance usage for reading
 reset sources
Message-ID: <1355774009-30208-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To read reset sources registers we have to use PRM_DEVICE_INST
---
 arch/arm/mach-omap2/prm44xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 7498bc7..0b61b8d 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -333,7 +333,7 @@ static u32 omap44xx_prm_read_reset_sources(void)
 	u32 r = 0;
 	u32 v;
 
-	v = omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
+	v = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
 				    OMAP4_RM_RSTST);
 
 	p = omap44xx_prm_reset_src_map;
-- 
1.7.9.5
