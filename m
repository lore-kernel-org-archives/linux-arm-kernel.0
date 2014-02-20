From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Thu, 20 Feb 2014 15:30:12 +0100
Subject: [PATCH] pinctrl: imx: Fix pin name in debug message.
Message-ID: <20140220143012.23570.63407.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wrong index counter was being used, causing the debug message
to show an incorrect pin name.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/pinctrl/pinctrl-imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 4779b8e..e118fb1 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -491,7 +491,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 			pin->mux_mode |= IOMUXC_CONFIG_SION;
 		pin->config = config & ~IMX_PAD_SION;
 
-		dev_dbg(info->dev, "%s: %d 0x%08lx", info->pins[i].name,
+		dev_dbg(info->dev, "%s: %d 0x%08lx", info->pins[pin_id].name,
 				pin->mux_mode, pin->config);
 	}
 
