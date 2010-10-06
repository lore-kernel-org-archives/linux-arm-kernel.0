From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Wed,  6 Oct 2010 10:53:50 +0200
Subject: [PATCH for 2.6.36 2/2] cpuimx27: fix i2c bus selection
In-Reply-To: <1286355230-15530-1-git-send-email-eric@eukrea.com>
References: <1286355230-15530-1-git-send-email-eric@eukrea.com>
Message-ID: <1286355230-15530-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent clean of i.MX devices registration changed the i2C bus number
selected for our platform (Freescale start peripheral ID at 1, kernel
now start it at 0 so i.MX27's i2c 1 is kernel's i2c 0).
Without this fix, i2c is unusable on this platform.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-imx/mach-cpuimx27.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 339150a..6830afd 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -259,7 +259,7 @@ static void __init eukrea_cpuimx27_init(void)
 	i2c_register_board_info(0, eukrea_cpuimx27_i2c_devices,
 				ARRAY_SIZE(eukrea_cpuimx27_i2c_devices));
 
-	imx27_add_i2c_imx1(&cpuimx27_i2c1_data);
+	imx27_add_i2c_imx0(&cpuimx27_i2c1_data);
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
-- 
1.7.0.4
