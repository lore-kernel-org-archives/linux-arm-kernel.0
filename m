From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 17 Oct 2011 15:12:43 +0200
Subject: [PATCH 3/3] spi/pl022: skip default configuration before suspending
Message-ID: <1318857163-32193-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>

The loading of the default configuration before suspending has
been in the driver since its inception, but it is not really
needed. Especially so since we take to all the trouble of
enabling and disabling power and clock just to do this. Let's
scrap this now.

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 0a1d8ed..29dc70f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2342,11 +2342,6 @@ static int pl022_suspend(struct amba_device *adev, pm_message_t state)
 		return status;
 	}
 
-	amba_vcore_enable(adev);
-	amba_pclk_enable(adev);
-	load_ssp_default_config(pl022);
-	amba_pclk_disable(adev);
-	amba_vcore_disable(adev);
 	dev_dbg(&adev->dev, "suspended\n");
 	return 0;
 }
-- 
1.7.3.2
