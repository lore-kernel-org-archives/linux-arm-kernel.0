From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Tue, 26 Jun 2018 11:35:00 +0200
Subject: [PATCH v2 07/12] ASoC: qdsp6: q6afe-dai: support dt based module
 loading
In-Reply-To: <20180626092016.9296-8-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-8-srinivas.kandagatla@linaro.org>
Message-ID: <20180626093500.GD25217@centauri.ideon.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:11AM +0100, Srinivas Kandagatla wrote:
> This patch uses new compatible string to make DT based module loading work.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6afe-dai.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
> index 5002dd05bf27..1d2e5013c121 100644
> --- a/sound/soc/qcom/qdsp6/q6afe-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
> @@ -1290,9 +1290,16 @@ static int q6afe_dai_dev_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id q6afe_dai_device_id[] = {
> +	{ .compatible = "qcom,q6afe-dais" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, q6afe_dai_device_id);
> +
>  static struct platform_driver q6afe_dai_platform_driver = {
>  	.driver = {
>  		.name = "q6afe-dai",
> +		.of_match_table = of_match_ptr(q6afe_dai_device_id),
>  	},
>  	.probe = q6afe_dai_dev_probe,
>  	.remove = q6afe_dai_dev_remove,
> -- 
> 2.16.2
> 
