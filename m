From: stefan@agner.ch (Stefan Agner)
Date: Sat,  6 Jan 2018 15:25:52 +0100
Subject: [PATCH v2 4/5] pinctrl: imx7ulp: constify struct imx_cfg_params_decode
In-Reply-To: <20180106142553.15322-1-stefan@agner.ch>
References: <20180106142553.15322-1-stefan@agner.ch>
Message-ID: <20180106142553.15322-5-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The decode parameters are constant mark them const.

Cc: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pinctrl/freescale/pinctrl-imx.c     | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx.h     | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 86256d25c4a3..24aaddd760a0 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -255,7 +255,7 @@ static u32 imx_pinconf_decode_generic_config(struct imx_pinctrl *ipctl,
 					      unsigned int num_configs)
 {
 	const struct imx_pinctrl_soc_info *info = ipctl->info;
-	struct imx_cfg_params_decode *decode;
+	const struct imx_cfg_params_decode *decode;
 	enum pin_config_param param;
 	u32 raw_config = 0;
 	u32 param_val;
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
index 41ee75537da4..038e8c0e5b96 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.h
+++ b/drivers/pinctrl/freescale/pinctrl-imx.h
@@ -71,7 +71,7 @@ struct imx_pinctrl_soc_info {
 	bool generic_pinconf;
 	const struct pinconf_generic_params *custom_params;
 	unsigned int num_custom_params;
-	struct imx_cfg_params_decode *decodes;
+	const struct imx_cfg_params_decode *decodes;
 	unsigned int num_decodes;
 	void (*fixup)(unsigned long *configs, unsigned int num_configs,
 		      u32 *raw_config);
diff --git a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
index 0406d8b39e6a..f363e45fd246 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
@@ -266,7 +266,7 @@ static const struct pinctrl_pin_desc imx7ulp_pinctrl_pads[] = {
 #define BP_MUX_MODE		8
 #define BM_PULL_ENABLED		BIT(1)
 
-struct imx_cfg_params_decode imx7ulp_cfg_decodes[] = {
+static const struct imx_cfg_params_decode imx7ulp_cfg_decodes[] = {
 	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_DRIVE_STRENGTH, 		BIT(6), 6),
 	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_DRIVE_PUSH_PULL,		BIT(5), 5),
 	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_SLEW_RATE,			BIT(2), 2),
-- 
2.15.1
