From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 04 Oct 2012 21:12:39 +0530
Subject: [PATCH v1 01/14] media: s5p-hdmi: add HPD GPIO to platform data
In-Reply-To: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
References: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1349365372-21417-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Stanislawski <t.stanislaws@samsung.com>

This patch extends s5p-hdmi platform data by a GPIO identifier for
Hot-Plug-Detection pin.

Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/media/s5p_hdmi.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/media/s5p_hdmi.h b/include/media/s5p_hdmi.h
index 361a751..181642b 100644
--- a/include/media/s5p_hdmi.h
+++ b/include/media/s5p_hdmi.h
@@ -20,6 +20,7 @@ struct i2c_board_info;
  * @hdmiphy_info: template for HDMIPHY I2C device
  * @mhl_bus: controller id for MHL control bus
  * @mhl_info: template for MHL I2C device
+ * @hpd_gpio: GPIO for Hot-Plug-Detect pin
  *
  * NULL pointer for *_info fields indicates that
  * the corresponding chip is not present
@@ -29,6 +30,7 @@ struct s5p_hdmi_platform_data {
 	struct i2c_board_info *hdmiphy_info;
 	int mhl_bus;
 	struct i2c_board_info *mhl_info;
+	int hpd_gpio;
 };
 
 #endif /* S5P_HDMI_H */
-- 
1.7.0.4
