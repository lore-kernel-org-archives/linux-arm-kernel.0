From: ospite@studenti.unina.it (Antonio Ospite)
Date: Fri,  2 Oct 2009 16:24:02 +0200
Subject: [PATCH] pxamci: fix printing gpio numbers in pxamci_probe
Message-ID: <1254493442-32312-1-git-send-email-ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 drivers/mmc/host/pxamci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 5e0b152..b00d673 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -693,7 +693,7 @@ static int pxamci_probe(struct platform_device *pdev)
 	if (gpio_is_valid(gpio_ro)) {
 		ret = gpio_request(gpio_ro, "mmc card read only");
 		if (ret) {
-			dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_power);
+			dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_ro);
 			goto err_gpio_ro;
 		}
 		gpio_direction_input(gpio_ro);
@@ -701,7 +701,7 @@ static int pxamci_probe(struct platform_device *pdev)
 	if (gpio_is_valid(gpio_cd)) {
 		ret = gpio_request(gpio_cd, "mmc card detect");
 		if (ret) {
-			dev_err(&pdev->dev, "Failed requesting gpio_cd %d\n", gpio_power);
+			dev_err(&pdev->dev, "Failed requesting gpio_cd %d\n", gpio_cd);
 			goto err_gpio_cd;
 		}
 		gpio_direction_input(gpio_cd);
-- 
1.6.4.3
