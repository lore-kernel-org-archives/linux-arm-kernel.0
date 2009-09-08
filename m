From: thomas.ab@samsung.com (thomas.ab at samsung.com)
Date: Tue,  8 Sep 2009 14:35:29 +0900
Subject: [PATCH 3/4] s3c6410: Fix divider value calculation in
	s3c64xx_roundrate_clksrc
Message-ID: <1252388129-22722-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

In s3c64xx_roundrate_clksrc function, the calculation is wrong. This
patch fixes this calculation.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 54eef93..9745852 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -345,7 +345,7 @@ static unsigned long s3c64xx_roundrate_clksrc(struct clk *clk,
 	if (rate > parent_rate)
 		rate = parent_rate;
 	else {
-		div = rate / parent_rate;
+		div = parent_rate / rate;
 
 		if (div == 0)
 			div = 1;
-- 
1.5.3.4
