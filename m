From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Sat,  2 Nov 2013 21:09:31 +0530
Subject: [PATCH v4 2/6] gpio: davinci: remove unnecessary printk
In-Reply-To: <1383406775-14902-1-git-send-email-prabhakar.csenng@gmail.com>
References: <1383406775-14902-1-git-send-email-prabhakar.csenng@gmail.com>
Message-ID: <1383406775-14902-3-git-send-email-prabhakar.csenng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

the devm_*() helper prints error messages in case of
errors no need to do the same in the driver.

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 drivers/gpio/gpio-davinci.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 6c90cfb..95c6df1 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -389,11 +389,9 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	}
 
 	clk = devm_clk_get(dev, "gpio");
-	if (IS_ERR(clk)) {
-		printk(KERN_ERR "Error %ld getting gpio clock?\n",
-		       PTR_ERR(clk));
+	if (IS_ERR(clk))
 		return PTR_ERR(clk);
-	}
+
 	clk_prepare_enable(clk);
 
 	/*
-- 
1.7.9.5
