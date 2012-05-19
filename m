From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 19 May 2012 21:06:13 +0800
Subject: [PATCH] mtd: nand: gpmi: fix compile error caused by pinctrl call
Message-ID: <1337432773-24000-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following compile error caused by commit 39febc0 (mtd: nand: gpmi:
adopt pinctrl support).

  CC      drivers/mtd/nand/gpmi-nand/gpmi-nand.o
drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function ?acquire_resources?:
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:499:45: error: ?pdev? undeclared (first use in this function)

Reported-by: Subodh Nijsure <snijsure@grid-net.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Hi Arnd, Olof,

Can you please apply the patch on top of arm-soc/imx/pinctrl branch or
amend commit 39febc0 (mtd: nand: gpmi: adopt pinctrl support) with the
fixing?  Sorry for this mistake.

Regards,
Shawn

 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 8478fd9..b68e043 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -496,7 +496,7 @@ static int __devinit acquire_resources(struct gpmi_nand_data *this)
 	if (ret)
 		goto exit_dma_channels;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	pinctrl = devm_pinctrl_get_select_default(&this->pdev->dev);
 	if (IS_ERR(pinctrl)) {
 		ret = PTR_ERR(pinctrl);
 		goto exit_pin;
-- 
1.7.5.4
