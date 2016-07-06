From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 6 Jul 2016 12:35:12 -0700
Subject: [PATCH 1/2] hwspinlock: qcom_hwspinlock: add missing of_node_put
 after calling of_parse_phandle
In-Reply-To: <1467684664-21155-1-git-send-email-peter.chen@nxp.com>
References: <1467684664-21155-1-git-send-email-peter.chen@nxp.com>
Message-ID: <20160706193512.GB23833@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 04 Jul 19:11 PDT 2016, Peter Chen wrote:

> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
> 
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-arm-msm at vger.kernel.org
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

Applied.

Please use get_maintainer.pl to find out whom to send patches to, I
only stumbled upon this while looking for something else.

Thanks,
Bjorn

> ---
>  drivers/hwspinlock/qcom_hwspinlock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
> index c752447..fa6880b 100644
> --- a/drivers/hwspinlock/qcom_hwspinlock.c
> +++ b/drivers/hwspinlock/qcom_hwspinlock.c
> @@ -98,6 +98,7 @@ static int qcom_hwspinlock_probe(struct platform_device *pdev)
>  	}
>  
>  	regmap = syscon_node_to_regmap(syscon);
> +	of_node_put(syscon);
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
