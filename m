From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 15 May 2012 11:56:38 +0800
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
Message-ID: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Same as what the driver does for data register shadow bgc->data,
the bgpio_init should also initialize direction register shadow
bgc->dir to preserve the existing setting.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpio/gpio-generic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
index e38dd0c..53222c7 100644
--- a/drivers/gpio/gpio-generic.c
+++ b/drivers/gpio/gpio-generic.c
@@ -394,6 +394,7 @@ int bgpio_init(struct bgpio_chip *bgc, struct device *dev,
 		return ret;
 
 	bgc->data = bgc->read_reg(bgc->reg_dat);
+	bgc->dir = bgc->read_reg(bgc->reg_dir);
 
 	return ret;
 }
-- 
1.7.4.1
