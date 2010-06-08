From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 Jun 2010 11:02:58 +0200
Subject: [PATCH 4/8] i.MX25: fix EHCI support
In-Reply-To: <1275987782-16094-3-git-send-email-eric@eukrea.com>
References: <1275987782-16094-1-git-send-email-eric@eukrea.com>
	<1275987782-16094-2-git-send-email-eric@eukrea.com>
	<1275987782-16094-3-git-send-email-eric@eukrea.com>
Message-ID: <1275987782-16094-4-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX25's EHCI is the same as i.MX35's one.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/usb/host/ehci-mxc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 544ccfd..56f2750 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -182,7 +182,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 	clk_enable(priv->usbclk);
 
-	if (!cpu_is_mx35()) {
+	if (!cpu_is_mx35() && !cpu_is_mx25()) {
 		priv->ahbclk = clk_get(dev, "usb_ahb");
 		if (IS_ERR(priv->ahbclk)) {
 			ret = PTR_ERR(priv->ahbclk);
-- 
1.6.3.3
