From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Thu, 19 Apr 2018 16:05:57 +0200
Subject: [PATCH 27/61] media: platform: s5p-mfc: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180419140641.27926-28-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/media/platform/s5p-mfc/s5p_mfc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index a80251ed3143..9ca707cb2a42 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1449,8 +1449,7 @@ static int s5p_mfc_remove(struct platform_device *pdev)
 
 static int s5p_mfc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s5p_mfc_dev *m_dev = platform_get_drvdata(pdev);
+	struct s5p_mfc_dev *m_dev = dev_get_drvdata(dev);
 	int ret;
 
 	if (m_dev->num_inst == 0)
@@ -1484,8 +1483,7 @@ static int s5p_mfc_suspend(struct device *dev)
 
 static int s5p_mfc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s5p_mfc_dev *m_dev = platform_get_drvdata(pdev);
+	struct s5p_mfc_dev *m_dev = dev_get_drvdata(dev);
 
 	if (m_dev->num_inst == 0)
 		return 0;
-- 
2.11.0
