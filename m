From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  6 Nov 2013 10:16:19 +0000
Subject: [PATCH 07/13] ASoC: ux500_pcm: Extract MSP IDs from Device Tree
In-Reply-To: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1383732985-18928-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required for indexing pre-defined channel configuration structures.

Cc: alsa-devel at alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/ux500_msp_i2s.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 1ca8b08..0a99372 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -665,6 +665,13 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
 				sizeof(struct msp_i2s_platform_data), GFP_KERNEL);
 			if (!platform_data)
 				return -ENOMEM;
+
+			if (!of_property_read_u32(np, "id",
+						  &platform_data->id)) {
+				dev_err(&pdev->dev,
+					"No 'id' property found in DT\n");
+				return -EINVAL;
+			}
 		}
 	} else
 		if (!platform_data)
-- 
1.8.1.2
