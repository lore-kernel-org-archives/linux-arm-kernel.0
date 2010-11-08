From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Nov 2010 09:18:08 +0100
Subject: [PATCH] arch/arm/plat-mxc/cpufreq.c: Fix line continuation defect
In-Reply-To: <1289164215.29216.315.camel@Joe-Laptop>
References: <1289164215.29216.315.camel@Joe-Laptop>
Message-ID: <20101108081808.GN16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On Sun, Nov 07, 2010 at 01:10:15PM -0800, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/arm/plat-mxc/cpufreq.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
> index 039538e..9f358af 100644
> --- a/arch/arm/plat-mxc/cpufreq.c
> +++ b/arch/arm/plat-mxc/cpufreq.c
> @@ -154,8 +154,8 @@ static int __init mxc_cpufreq_init(struct cpufreq_policy *policy)
>  	ret = cpufreq_frequency_table_cpuinfo(policy, imx_freq_table);
>  
>  	if (ret < 0) {
> -		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq \
> -				with error code %d\n", __func__, ret);
> +		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq with error code %d\n",
> +		       __func__, ret);
I'd prefer
+		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq "
+				"with error code %d\n", __func__, ret);

(actually I'd consider

+		pr_err("failed to register i.MXC CPUfreq (error: %d)\n", ret)

even better, but this is out of scope for this patch, isn't it?)

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
