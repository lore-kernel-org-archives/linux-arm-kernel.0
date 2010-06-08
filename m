From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 Jun 2010 11:02:59 +0200
Subject: [PATCH 5/8] i.MX25: fix USB gadget support
In-Reply-To: <1275987782-16094-4-git-send-email-eric@eukrea.com>
References: <1275987782-16094-1-git-send-email-eric@eukrea.com>
	<1275987782-16094-2-git-send-email-eric@eukrea.com>
	<1275987782-16094-3-git-send-email-eric@eukrea.com>
	<1275987782-16094-4-git-send-email-eric@eukrea.com>
Message-ID: <1275987782-16094-5-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX25's udc port is the same as i.MX35's one

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/usb/gadget/fsl_mxc_udc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index d0b8bde..eafa6d2 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -30,7 +30,7 @@ int fsl_udc_clk_init(struct platform_device *pdev)
 
 	pdata = pdev->dev.platform_data;
 
-	if (!cpu_is_mx35()) {
+	if (!cpu_is_mx35() && !cpu_is_mx25()) {
 		mxc_ahb_clk = clk_get(&pdev->dev, "usb_ahb");
 		if (IS_ERR(mxc_ahb_clk))
 			return PTR_ERR(mxc_ahb_clk);
-- 
1.6.3.3
