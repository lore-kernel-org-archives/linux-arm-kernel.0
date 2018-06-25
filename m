From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Mon, 25 Jun 2018 20:03:42 +0200
Subject: [PATCH 10/11] ASoC: qcom: apq8096: remove redundant owner
 assignment
In-Reply-To: <20180625143115.8346-11-srinivas.kandagatla@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-11-srinivas.kandagatla@linaro.org>
Message-ID: <20180625180342.GH10876@centauri.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Mon, Jun 25, 2018 at 03:31:14PM +0100, Srinivas Kandagatla wrote:
> module owner is already set in platform_driver_register(), so remove this
> redundant assignment.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/apq8096.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
> index 561cd429e6f2..6e79fec7e789 100644
> --- a/sound/soc/qcom/apq8096.c
> +++ b/sound/soc/qcom/apq8096.c
> @@ -245,7 +245,6 @@ static struct platform_driver msm_snd_apq8096_driver = {
>  	.remove = apq8096_platform_remove,
>  	.driver = {
>  		.name = "msm-snd-apq8096",
> -		.owner = THIS_MODULE,
>  		.of_match_table = msm_snd_apq8096_dt_match,
>  	},
>  };
> -- 
> 2.16.2
> 
