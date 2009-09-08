From: thomas.ab@samsung.com (thomas.ab at samsung.com)
Date: Tue,  8 Sep 2009 14:30:48 +0900
Subject: [PATCH 2/4] s3c6410: update clk->parent when setting clock source
Message-ID: <1252387848-21869-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This ensures the clock hierarchy data structures are
updated when we change the clock source in the actual
hardware registers.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index c972d2f..54eef93 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -328,6 +328,8 @@ static int s3c64xx_setparent_clksrc(struct clk *clk, struct clk *parent)
 		clksrc |= src_nr << sclk->shift;
 
 		__raw_writel(clksrc, S3C_CLK_SRC);
+
+		clk->parent = parent;
 		return 0;
 	}
 
-- 
1.5.3.4
