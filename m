From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu,  9 Jun 2016 13:02:46 +0100
Subject: [PATCH] ARM: imx: add mx25_revision() prototype
Message-ID: <1465473766-30463-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It looks like when this header was created, mx25_revision's
prototype was not added. Add it to fix the following warning:

arch/arm/mach-imx/cpu-imx25.c:44:5: warning: symbol 'mx25_revision' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 include/soc/imx/revision.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/soc/imx/revision.h b/include/soc/imx/revision.h
index 9ea3469..b10af49 100644
--- a/include/soc/imx/revision.h
+++ b/include/soc/imx/revision.h
@@ -25,6 +25,7 @@
 #define IMX_CHIP_REVISION_3_3		0x33
 #define IMX_CHIP_REVISION_UNKNOWN	0xff
 
+int mx25_revision(void);
 int mx27_revision(void);
 int mx31_revision(void);
 int mx35_revision(void);
-- 
2.8.1
