From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Thu,  8 Mar 2018 22:35:40 +0100
Subject: [PATCH] arm64: defconfig: enable Rockchip io-domain driver
Message-ID: <20180308213540.4309-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner justified pretty well the change in commit e330eb86ba0
'ARM: multi_v7_defconfig: enable Rockchip io-domain driver'. This change
is also needed for arm64 rockchip boards, so, do the same for arm64.

The io-domain driver is necessary to notify the soc about voltages
changes happening on supplying regulators. Probably the most important
user right now is the mmc tuning code, where the soc needs to get
notified when the voltage is dropped to the 1.8V point.

As this option is necessary to successfully tune UHS cards etc, it
should get built in. Otherwise, tunning will fail with,

   dwmmc_rockchip fe320000.dwmmc: All phases bad!
   mmc0: tuning execution failed: -5

Cc: Heiko St?bner <heiko@sntech.de>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ba859709c2d4..d65d53b1ff77 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -313,6 +313,8 @@ CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_MAX77620=y
+CONFIG_POWER_AVS=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
-- 
2.16.1
