From: thomas.ab@samsung.com (thomas.ab at samsung.com)
Date: Tue,  8 Sep 2009 14:40:01 +0900
Subject: [PATCH 4/4] s3c6410: Remove redundant mpll parent assignment.
Message-ID: <1252388401-31529-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch removes the redundant MPLL parent assignment
in the function s3c6400_register_clocks.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 9745852..72c03ab 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -758,6 +758,5 @@ void __init s3c6400_register_clocks(unsigned armclk_divlimit)
 		}
 	}
 
-	clk_mpll.parent = &clk_mout_mpll.clk;
 	clk_epll.parent = &clk_mout_epll.clk;
 }
-- 
1.5.3.4
