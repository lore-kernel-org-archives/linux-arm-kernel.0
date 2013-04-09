From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Tue, 9 Apr 2013 11:07:30 -0300
Subject: [PATCH v2 2/4] imx-drm: parallel-display: Make IPU KMS parse
 display-timings
In-Reply-To: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
References: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <1365516452-1287-2-git-send-email-rogerio.pimentel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for parsing of the DT display-timings prop
to IPU KMS driver.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
---
Changes since v1:
Moved the function of_get_drm_display_mode from 
imx_pd_connector_get_modes function to probe function
 drivers/staging/imx-drm/parallel-display.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 49c90c3..adc011d 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -232,6 +232,8 @@ static int imx_pd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, imxpd);
 
+	of_get_drm_display_mode(np, &imxpd->mode, 0);
+
 	return 0;
 }
 
-- 
1.7.10.4
