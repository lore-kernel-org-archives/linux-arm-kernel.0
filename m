From: tobetter@gmail.com (Dongjin Kim)
Date: Mon,  6 Aug 2012 22:57:39 +0900
Subject: [PATCH] ARM: EXYNOS: Add HDMIPHY I2C adaptor
In-Reply-To: <1344261462-14183-1-git-send-email-dongjin.kim@agreeyamobility.net>
References: <1344261462-14183-1-git-send-email-dongjin.kim@agreeyamobility.net>
Message-ID: <1344261462-14183-2-git-send-email-dongjin.kim@agreeyamobility.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch assign the I2C channel for HDMIPHY for Exynos4x12
in s5p_i2c_hdmiphy_set_platdata() and s5p_hdmi_set_platdata()

Change-Id: I7e66c8f9327e2f7dce7440efb8583b506d65831a
Signed-off-by: Dongjin Kim <dongjin.kim@agreeyamobility.net>
---
 arch/arm/plat-samsung/devs.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index a199e55..54614d0 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -752,6 +752,8 @@ void __init s5p_i2c_hdmiphy_set_platdata(struct s3c2410_platform_i2c *pd)
 
 		if (soc_is_exynos4210())
 			pd->bus_num = 8;
+		else if (soc_is_exynos4212() || soc_is_exynos4412())
+			pd->bus_num = 8;
 		else if (soc_is_s5pv210())
 			pd->bus_num = 3;
 		else
@@ -771,6 +773,8 @@ void __init s5p_hdmi_set_platdata(struct i2c_board_info *hdmiphy_info,
 
 	if (soc_is_exynos4210())
 		pd->hdmiphy_bus = 8;
+	else if (soc_is_exynos4212() || soc_is_exynos4412())
+		pd->hdmiphy_bus = 8;
 	else if (soc_is_s5pv210())
 		pd->hdmiphy_bus = 3;
 	else
-- 
1.7.9.5
