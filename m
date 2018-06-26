From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Tue, 26 Jun 2018 11:35:37 +0200
Subject: [PATCH v2 09/12] ASoC: qdsp6: q6routing: support dt based module
 loading
In-Reply-To: <20180626092016.9296-10-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-10-srinivas.kandagatla@linaro.org>
Message-ID: <20180626093537.GF25217@centauri.ideon.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:13AM +0100, Srinivas Kandagatla wrote:
> This patch uses new compatible string to make DT based module loading work.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6routing.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
> index 593f66b8622f..ab696bf8d1d3 100644
> --- a/sound/soc/qcom/qdsp6/q6routing.c
> +++ b/sound/soc/qcom/qdsp6/q6routing.c
> @@ -993,9 +993,16 @@ static int q6pcm_routing_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id q6pcm_routing_device_id[] = {
> +	{ .compatible = "qcom,q6adm-routing" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, q6pcm_routing_device_id);
> +
>  static struct platform_driver q6pcm_routing_platform_driver = {
>  	.driver = {
>  		.name = "q6routing",
> +		.of_match_table = of_match_ptr(q6pcm_routing_device_id),
>  	},
>  	.probe = q6pcm_routing_probe,
>  	.remove = q6pcm_routing_remove,
> -- 
> 2.16.2
> 
