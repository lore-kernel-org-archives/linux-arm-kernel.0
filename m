From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 May 2012 15:35:03 +0800
Subject: [PATCH 2/2] gpio/mxc: remove basic_mmio_gpio shadow fixup
In-Reply-To: <1337240103-4756-1-git-send-email-shawn.guo@linaro.org>
References: <1337240103-4756-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1337240103-4756-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 7cc9c7c (gpio/generic: initialize basic_mmio_gpio shadow
variables properly) fixing the basic_mmio_gpio shadow variables in
gpio-generic, the fixup in gpio-mxc can be removed now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpio/gpio-mxc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index e791476..dbaac01 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -423,8 +423,6 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 
 	port->bgc.gc.to_irq = mxc_gpio_to_irq;
 	port->bgc.gc.base = pdev->id * 32;
-	port->bgc.dir = port->bgc.read_reg(port->bgc.reg_dir);
-	port->bgc.data = port->bgc.read_reg(port->bgc.reg_set);
 
 	err = gpiochip_add(&port->bgc.gc);
 	if (err)
-- 
1.7.5.4
