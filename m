From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 14 Dec 2011 08:47:28 +0800
Subject: [PATCH V2 4/7] arm/imx: fix cpufreq section mismatch
In-Reply-To: <1323757530-19402-5-git-send-email-richard.zhao@linaro.org>
References: <1323757530-19402-1-git-send-email-richard.zhao@linaro.org>
 <1323757530-19402-5-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111214004727.GJ28768@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

can this fix go in?

Thanks
Richard
On Tue, Dec 13, 2011 at 02:25:27PM +0800, Richard Zhao wrote:
> WARNING: arch/arm/plat-mxc/built-in.o(.data+0x488): Section mismatch in reference from the variable mxc_driver to the function .init.text:mxc_cpufreq_init()
> The variable mxc_driver references
> the function __init mxc_cpufreq_init()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/plat-mxc/cpufreq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
> index 85d037f..71e0d09 100644
> --- a/arch/arm/plat-mxc/cpufreq.c
> +++ b/arch/arm/plat-mxc/cpufreq.c
> @@ -120,7 +120,7 @@ static int mxc_set_target(struct cpufreq_policy *policy,
>  	return ret;
>  }
>  
> -static int __init mxc_cpufreq_init(struct cpufreq_policy *policy)
> +static int mxc_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	int ret;
>  	int i;
> -- 
> 1.7.5.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
