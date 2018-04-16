From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Mon, 16 Apr 2018 11:39:57 -0300
Subject: [PATCH 2/7] arm64: defconfig: Enable Rockchip io-domain driver
In-Reply-To: <20180416144002.15569-1-ezequiel@collabora.com>
References: <20180416144002.15569-1-ezequiel@collabora.com>
Message-ID: <20180416144002.15569-3-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>


Heiko St?bner justified pretty well the change in commit e330eb86ba0b
("ARM: multi_v7_defconfig: enable Rockchip io-domain driver"). This
change is also needed for arm64 rockchip boards, so, do the same for arm64.

The io-domain driver is necessary to notify the soc about voltages
changes happening on supplying regulators. Probably the most important
user right now is the mmc tuning code, where the soc needs to get
notified when the voltage is dropped to the 1.8V point.

As this option is necessary to successfully tune UHS cards etc, it
should get built in. Otherwise, tuning will fail with,

   dwmmc_rockchip fe320000.dwmmc: All phases bad!
   mmc0: tuning execution failed: -5

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bdd594387232..7e3b3f0484b9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -332,6 +332,8 @@ CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_MAX77620=y
+CONFIG_POWER_AVS=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
-- 
2.16.3
