From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 25 Jan 2012 15:23:26 +0100
Subject: [PATCH 5/6] ARM: SAMSUNG: Correct M-5MOLS sensor clock frequency on
 Nuri board
In-Reply-To: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
References: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1327501407-1927-6-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to keep the sensor's master clock frequency in valid range
when FIMC parent clock is xusbxti, the specified frequency must be
exactly 24MHZ, otherwise it's being set to too low value due to
rounding.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-universal_c210.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 44fc43e..0e3aeb9 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -973,7 +973,7 @@ static struct s5p_fimc_isp_info universal_camera_sensors[] = {
 		.bus_type	= FIMC_MIPI_CSI2,
 		.board_info	= &m5mols_board_info,
 		.i2c_bus_num	= 0,
-		.clk_frequency	= 21600000UL,
+		.clk_frequency	= 24000000UL,
 		.csi_data_align	= 32,
 	},
 };
-- 
1.7.8.3
