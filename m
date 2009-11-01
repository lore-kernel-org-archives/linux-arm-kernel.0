From: thomas.ab@samsung.com (Thomas Abraham)
Date: Sun,  1 Nov 2009 13:55:24 +0900
Subject: [PATCH 4/7] S3C64XX: Add clock source definition for IDE controller.
Message-ID: <1257051324-8124-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock source definition for S3C IDE controller.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c64xx/clock.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/plat-s3c64xx/clock.c
index 7a36e89..9de38bf 100644
--- a/arch/arm/plat-s3c64xx/clock.c
+++ b/arch/arm/plat-s3c64xx/clock.c
@@ -256,6 +256,12 @@ static struct clk init_clocks[] = {
 		.id		= -1,
 		.parent		= &clk_p,
 		.ctrlbit	= S3C_CLKCON_PCLK_AC97,
+	}, {
+		.name		= "cfcon",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_IHOST
 	}
 };
 
-- 
1.5.3.4
