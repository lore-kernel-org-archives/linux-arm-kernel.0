From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 01:00:13 +0900
Subject: [PATCH 3/4] ASoC: fsl: Constify platform_device_id
In-Reply-To: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430496014-32309-3-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 sound/soc/fsl/imx-audmux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index d9050d946ae7..fc57da341d61 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -184,7 +184,7 @@ static enum imx_audmux_type {
 	IMX31_AUDMUX,
 } audmux_type;
 
-static struct platform_device_id imx_audmux_ids[] = {
+static const struct platform_device_id imx_audmux_ids[] = {
 	{
 		.name = "imx21-audmux",
 		.driver_data = IMX21_AUDMUX,
-- 
2.1.4
