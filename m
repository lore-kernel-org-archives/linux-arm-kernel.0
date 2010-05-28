From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 28 May 2010 04:45:33 +0200
Subject: [PATCH 2/2] pxa/z2: Register WM8750
In-Reply-To: <1275014733-21588-1-git-send-email-marek.vasut@gmail.com>
References: <1275014733-21588-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1275014733-21588-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch registers the WM8750 codec on a proper place on the ZipitZ2
machine after the WM8750 driver was converted to new API.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/z2.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 194865e..4cba5b6 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -479,7 +479,10 @@ static struct i2c_board_info __initdata z2_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("aer915", 0x55),
 		.platform_data	= &batt_chip_info,
-	}
+	}, {
+		I2C_BOARD_INFO("wm8750", 0x1b),
+	},
+
 };
 
 static void __init z2_i2c_init(void)
-- 
1.7.0
