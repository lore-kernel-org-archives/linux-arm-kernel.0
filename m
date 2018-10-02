From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Tue, 2 Oct 2018 16:10:38 +0800
Subject: [PATCH v4 08/11] drm/mediatek: add support for SPDIF audio in HDMI
In-Reply-To: <20181002081041.32629-1-bibby.hsieh@mediatek.com>
References: <20181002081041.32629-1-bibby.hsieh@mediatek.com>
Message-ID: <20181002081041.32629-9-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: chunhui dai <chunhui.dai@mediatek.com>

add support for SPDIF audio  in HDMI

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 2ca9f6a64dab..d62e685cec73 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1576,6 +1576,11 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
 		hdmi_params.aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
 		hdmi_params.aud_mclk = HDMI_AUD_MCLK_128FS;
 		break;
+	case HDMI_SPDIF:
+		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
+		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		hdmi_params.aud_input_type = HDMI_AUD_INPUT_SPDIF;
+		break;
 	default:
 		dev_err(hdmi->dev, "%s: Invalid DAI format %d\n", __func__,
 			daifmt->fmt);
-- 
2.12.5.2.gbdf23ab
