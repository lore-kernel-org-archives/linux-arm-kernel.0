From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 30 Oct 2013 20:45:09 +0000
Subject: [PATCH 6/6] imx-drm: hdmi: minor cleanups
In-Reply-To: <20131030193622.GN16735@n2100.arm.linux.org.uk>
References: <20131030193622.GN16735@n2100.arm.linux.org.uk>
Message-ID: <E1VbcdZ-000633-My@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some minor cleanups to the HDMI driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 1eb12c57aa3e..ee0fceb7b5b2 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -19,7 +19,6 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
-
 #include <linux/of_device.h>
 
 #include <drm/drmP.h>
@@ -37,7 +36,7 @@
 #define YCBCR444		1
 #define YCBCR422_16BITS		2
 #define YCBCR422_8BITS		3
-#define	XVYCC444		4
+#define XVYCC444		4
 
 enum hdmi_datamap {
 	RGB444_8B = 0x01,
@@ -1762,8 +1761,8 @@ static int imx_hdmi_platform_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *ddc_node;
 	struct imx_hdmi *hdmi;
-	int ret, irq;
 	struct resource *iores;
+	int ret, irq;
 
 	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
-- 
1.7.4.4
