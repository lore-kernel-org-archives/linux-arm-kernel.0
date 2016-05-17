From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 17 May 2016 13:29:53 +0530
Subject: [PATCH v4 12/18] arm: use of_platform_default_populate() to
 populate
In-Reply-To: <1463054775-18170-13-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
 <1463054775-18170-13-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <573ACF79.1090600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 May 2016 05:36 PM, Kefeng Wang wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Roland Stigge <stigge@antcom.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index c4b5808..da46dc7 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -54,8 +54,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>  
>  static void __init da850_init_machine(void)
>  {
> -	of_platform_populate(NULL, of_default_bus_match_table,
> -			     da850_auxdata_lookup, NULL);
> +	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
>  
>  }

The mach-davinci change is already queued for v4.7

Thanks,
Sekhar
