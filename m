From: geliangtang@163.com (Geliang Tang)
Date: Sun, 27 Dec 2015 21:15:42 +0800
Subject: [PATCH 04/10] i2c: st: use to_platform_device()
In-Reply-To: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
Message-ID: <18b3804a2b8d7c682f3f25951309e1503d8ab6d0.1451221174.git.geliangtang@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/i2c/busses/i2c-st.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 25020ec..6ee7715 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -708,8 +708,7 @@ static int st_i2c_xfer(struct i2c_adapter *i2c_adap,
 #ifdef CONFIG_PM_SLEEP
 static int st_i2c_suspend(struct device *dev)
 {
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct st_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
 
 	if (i2c_dev->busy)
-- 
2.5.0
