From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 03 Mar 2011 20:04:20 +0100
Subject: [PATCH v2 2/3] ARM: S5P: Extend MIPI-CSIS platform_data with the PHY
	control callback
In-Reply-To: <01a701cbd95d$9873c160$c95b4420$%kim@samsung.com>
References: <01a701cbd95d$9873c160$c95b4420$%kim@samsung.com>
Message-ID: <1299179061-30959-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend MIPI-CSIS driver's platform data structure with a callback
for D-PHY enable and reset control.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5p/include/plat/mipi_csis.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s5p/include/plat/mipi_csis.h b/arch/arm/plat-s5p/include/plat/mipi_csis.h
index eb3beab..8a9e88a 100644
--- a/arch/arm/plat-s5p/include/plat/mipi_csis.h
+++ b/arch/arm/plat-s5p/include/plat/mipi_csis.h
@@ -11,6 +11,8 @@
 #ifndef PLAT_S5P_MIPI_CSIS_H_
 #define PLAT_S5P_MIPI_CSIS_H_ __FILE__
 
+struct platform_device;
+
 /**
  * struct s5p_platform_mipi_csis - platform data for S5P MIPI-CSIS driver
  * @clk_rate: bus clock frequency
@@ -23,6 +25,15 @@ struct s5p_platform_mipi_csis {
 	u8 lanes;
 	u8 alignment;
 	u8 hs_settle;
+	int (*phy_enable)(struct platform_device *pdev, bool on);
 };
 
+/**
+ * s5p_csis_phy_enable - global MIPI-CSI receiver D-PHY control
+ * @pdev: MIPI-CSIS platform device
+ * @on: true to enable D-PHY and deassert its reset
+ *	false to disable D-PHY
+ */
+int s5p_csis_phy_enable(struct platform_device *pdev, bool on);
+
 #endif /* PLAT_S5P_MIPI_CSIS_H_ */
-- 
1.7.4.1
