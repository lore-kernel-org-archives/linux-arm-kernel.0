From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 01 Feb 2016 15:22:44 +0100
Subject: [PATCH v2 01/15] arm: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1453881180-12296-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-2-git-send-email-wangkefeng.wang@huawei.com>
 <1453881180-12296-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1694609.jjsREDbl4R@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 27. Januar 2016, 15:53:00 schrieb Kefeng Wang:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---


> diff --git a/arch/arm/mach-rockchip/rockchip.c
> b/arch/arm/mach-rockchip/rockchip.c index 3f07cc5..07ef8ef 100644
> --- a/arch/arm/mach-rockchip/rockchip.c
> +++ b/arch/arm/mach-rockchip/rockchip.c
> @@ -73,7 +73,7 @@ static void __init rockchip_timer_init(void)
>  static void __init rockchip_dt_init(void)
>  {
>  	rockchip_suspend_init();
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	of_platform_default_populate(NULL, NULL, NULL);
>  	platform_device_register_simple("cpufreq-dt", 0, NULL, 0);
>  }

sounds sensible, so

Acked-by: Heiko Stuebner <heiko@sntech.de>
