From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 16 Feb 2016 10:32:17 +0100
Subject: [PATCH v2 01/15] arm: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1453881180-12296-1-git-send-email-wangkefeng.wang@huawei.com>
 (Kefeng Wang's message of "Wed, 27 Jan 2016 15:53:00 +0800")
References: <1453868872-26300-2-git-send-email-wangkefeng.wang@huawei.com>
 <1453881180-12296-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <m38u2lq9um.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:

> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> --- a/arch/arm/mach-cns3xxx/core.c
> +++ b/arch/arm/mach-cns3xxx/core.c
> @@ -395,8 +395,7 @@ static void __init cns3xxx_init(void)
>  
>  	pm_power_off = cns3xxx_power_off;
>  
> -	of_platform_populate(NULL, of_default_bus_match_table,
> -                        cns3xxx_auxdata, NULL);
> +	of_platform_default_populate(NULL, cns3xxx_auxdata, NULL);
>  }
>  

Doesn't look wrong :-)

Acked-by: Krzysztof Halasa <khalasa@piap.pl>

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
