From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 13:08:49 +0200
Subject: [PATCH v10 04/11] ARM: hisi: enable HiP04
In-Reply-To: <1404957850-13340-5-git-send-email-haojian.zhuang@linaro.org>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
 <1404957850-13340-5-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <201407281308.49775.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 July 2014, Haojian Zhuang wrote:
> --- a/arch/arm/mach-hisi/platmcpm.c
> +++ b/arch/arm/mach-hisi/platmcpm.c
> @@ -116,7 +116,6 @@ static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
>                CORE_DEBUG_RESET_BIT(cpu);
>         writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
>         spin_unlock_irq(&boot_lock);
> -       msleep(POLL_MSEC);
>  
>         return 0;
>  }

Is this change intentional? It seems like it should belong into the earlier patch
that introduces this file.

	Arnd
