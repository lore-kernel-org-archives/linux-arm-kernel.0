From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Jan 2018 16:27:12 +0000
Subject: [RESEND PATCH v2 11/15] ASoC: qcom: qdsp6: Add support to q6afe
 dai driver
In-Reply-To: <20180102232811.GS478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-12-srinivas.kandagatla@linaro.org>
 <20180102232811.GS478@tuxbook>
Message-ID: <4edcacb6-6567-8f1a-dd71-cbcce0a66e06@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/01/18 23:28, Bjorn Andersson wrote:
> On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:
> 
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to q6afe backend dais driver.
>>
> 
> Isn't the list of backend DAIs platform-dependent?

dai links and connections between backend and front ends are platform 
dependent.

> 
> [..]
>> +static const struct snd_soc_dapm_widget hdmi_dapm_widgets[] = {
>> +	SND_SOC_DAPM_AIF_OUT("HDMI", "HDMI Playback", 0, 0, 0, 0),
>> +	SND_SOC_DAPM_OUTPUT("HDMI-RX"),
>> +};
>> +
>> +static const struct snd_soc_component_driver msm_dai_hdmi_q6_component = {
> 
> How will this look beyond HDMI? I'm having issues mapping this to
> downstream.

ex:
For slimbus dais, we would have more entries of "struct 
snd_soc_dai_driver" in this file.

Basically these are the dais that are exposed by the dsp firmware.

Depending on the actually platform some of these dais would be setup 
accordingly.


> 
>> +	.name		= "msm-dai-q6-hdmi",
>> +	.dapm_widgets = hdmi_dapm_widgets,
>> +	.num_dapm_widgets = ARRAY_SIZE(hdmi_dapm_widgets),
>> +	.controls = hdmi_config_controls,
>> +	.num_controls = ARRAY_SIZE(hdmi_config_controls),
>> +	.dapm_routes = hdmi_dapm_routes,
>> +	.num_dapm_routes = ARRAY_SIZE(hdmi_dapm_routes),
>> +};
>> +
> 
> Regards,
> Bjorn
> 
