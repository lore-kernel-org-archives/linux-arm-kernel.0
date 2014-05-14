From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 May 2014 15:04:51 +0200
Subject: [PATCH v5 4/6] driver: cpuidle: cpuidle-big-little: init driver
 for Exynos5420
In-Reply-To: <1400054637-21505-5-git-send-email-chander.kashyap@linaro.org>
References: <ANuQgHGSPJ45tbrVppAVpOqF0OfHacPWfX=S5mOVxTPr66f7vg@mail.gmail.com>
 <1400054637-21505-1-git-send-email-chander.kashyap@linaro.org>
 <1400054637-21505-5-git-send-email-chander.kashyap@linaro.org>
Message-ID: <5587958.90ud9NuKXm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 May 2014 13:33:55 Chander Kashyap wrote:
> 
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index 4cd02bd..344d79fa 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -165,6 +165,7 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_id)
>  
>  static const struct of_device_id compatible_machine_match[] = {
>         { .compatible = "arm,vexpress,v2p-ca15_a7" },
> +       { .compatible = "samsung,exynos5420" },
>         {},
>  };

Does the cpuidle-big_little driver actually care about the platform?
If not, it would be good to add a generic string here as well, for
future platforms to match.

It still makes sense to list both the generic string and the platform
specific one though, in case we have to work around subtle differences.

	Arnd
