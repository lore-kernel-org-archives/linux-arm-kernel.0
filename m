From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 2 Jan 2018 15:28:11 -0800
Subject: [RESEND PATCH v2 11/15] ASoC: qcom: qdsp6: Add support to q6afe
 dai driver
In-Reply-To: <20171214173402.19074-12-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-12-srinivas.kandagatla@linaro.org>
Message-ID: <20180102232811.GS478@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support to q6afe backend dais driver.
> 

Isn't the list of backend DAIs platform-dependent?

[..]
> +static const struct snd_soc_dapm_widget hdmi_dapm_widgets[] = {
> +	SND_SOC_DAPM_AIF_OUT("HDMI", "HDMI Playback", 0, 0, 0, 0),
> +	SND_SOC_DAPM_OUTPUT("HDMI-RX"),
> +};
> +
> +static const struct snd_soc_component_driver msm_dai_hdmi_q6_component = {

How will this look beyond HDMI? I'm having issues mapping this to
downstream.

> +	.name		= "msm-dai-q6-hdmi",
> +	.dapm_widgets = hdmi_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(hdmi_dapm_widgets),
> +	.controls = hdmi_config_controls,
> +	.num_controls = ARRAY_SIZE(hdmi_config_controls),
> +	.dapm_routes = hdmi_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(hdmi_dapm_routes),
> +};
> +

Regards,
Bjorn
