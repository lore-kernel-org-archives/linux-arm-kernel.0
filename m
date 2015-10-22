From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 22 Oct 2015 12:11:22 +0200
Subject: [PATCH 1/4] cpufreq: imx6q: Fix goto wrong error label
In-Reply-To: <1445503652-777-2-git-send-email-s.hauer@pengutronix.de>
References: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
 <1445503652-777-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1445508682.3173.24.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 22.10.2015, 10:47 +0200 schrieb Sascha Hauer:
> After the call to dev_pm_opp_init_cpufreq_table() we have to go to
> out_free_opp because we have already allocated the opp.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index ef1fa81..fabd144 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -256,7 +256,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
>  	if (ret) {
>  		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> -		goto put_reg;
> +		goto out_free_opp;
>  	}
>  
>  	/* Make imx6_soc_volt array's size same as arm opp number */

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
