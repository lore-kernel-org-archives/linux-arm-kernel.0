From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 6 Sep 2018 11:37:42 +0800
Subject: [PATCH v2 09/13] drm/mediatek: add support for SPDIF audio in HDMI
In-Reply-To: <20180905083146.14727-10-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
 <20180905083146.14727-10-bibby.hsieh@mediatek.com>
Message-ID: <1536205062.4618.23.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bibby:

On Wed, 2018-09-05 at 16:31 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> add support for SPDIF audio  in HDMI
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 2cb33098ec1a..cd8aaeebb436 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1594,6 +1594,11 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
>  		hdmi_params.aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
>  		hdmi_params.aud_mclk = HDMI_AUD_MCLK_128FS;
>  		break;
> +	case HDMI_SPDIF:
> +		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
> +		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
> +		hdmi_params.aud_input_type = HDMI_AUD_INPUT_SPDIF;
> +		break;
>  	default:
>  		dev_err(hdmi->dev, "%s: Invalid DAI format %d\n", __func__,
>  			daifmt->fmt);
