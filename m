From: rohitkr@codeaurora.org (Rohit Kumar)
Date: Thu, 22 Feb 2018 16:30:59 +0530
Subject: [alsa-devel] [PATCH v3 24/25] ASoC: qcom: apq8096: Add db820c
 machine driver
In-Reply-To: <20180213165837.1620-25-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-25-srinivas.kandagatla@linaro.org>
Message-ID: <2d646729-9bb2-86e5-22f5-19aaf009c0cc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/13/2018 10:28 PM, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to DB820c machine driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/Kconfig   |   8 +++
>   sound/soc/qcom/apq8096.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 181 insertions(+)
>   create mode 100644 sound/soc/qcom/apq8096.c
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 8c2d65e0a28e..fa4b575c086c 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -77,3 +77,11 @@ config SND_SOC_QDSP6
>   	 This will enable sound soc platform specific
>   	 audio drivers. This includes q6asm, q6adm,
>   	 q6afe interfaces to DSP using apr.
> +
> +config SND_SOC_MSM8996
> +	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
> +	depends on QCOM_APR
> +	select SND_SOC_QDSP6V2
should be select SND_SOC_QDSP6, V2 is not defined
> +	default n
> +	help
> +	 To add support for SoC audio on MSM8996 and APQ8096 boards
>
