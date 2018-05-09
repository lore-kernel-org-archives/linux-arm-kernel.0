From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Wed, 9 May 2018 02:42:34 -0700
Subject: [PATCH v7 20/24] ASoC: qdsp6: q6afe: Add q6afe dai driver
In-Reply-To: <20180501120820.11016-21-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-21-srinivas.kandagatla@linaro.org>
Message-ID: <22a39a17-36ef-3e94-e91b-11d303559ae4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to q6afe backend dais driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig           |   4 +
>   sound/soc/qcom/qdsp6/Makefile    |   1 +
>   sound/soc/qcom/qdsp6/q6afe-dai.c | 752 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 757 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6afe-dai.c
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 43f9ed85efa8..d3523a30d942 100644
> --- a/sound/soc/qcom/Kconfig
<snip>
> +};
> +
> +static int msm_dai_q6_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
> +	struct snd_soc_dapm_context *dapm;
> +	struct q6afe_port *port;
> +
> +	dapm = snd_soc_component_get_dapm(dai->component);
dapm unused here?

LGTM otherwise.
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
