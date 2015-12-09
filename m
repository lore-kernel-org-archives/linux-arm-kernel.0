From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 10:15:54 +0100
Subject: [PATCH v5 08/11] ARM: STi: Register CPUFreq device
In-Reply-To: <1449585124-15596-9-git-send-email-lee.jones@linaro.org>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-9-git-send-email-lee.jones@linaro.org>
Message-ID: <3682335.fAt9xNcJFr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 December 2015 14:32:01 Lee Jones wrote:
> @@ -161,3 +166,11 @@ struct smp_operations __initdata sti_smp_ops = {
>         .smp_secondary_init     = sti_secondary_init,
>         .smp_boot_secondary     = sti_boot_secondary,
>  };
> +
> +/**
> + * CPUFreq Registration
> + */
> +void init_cpufreq(void)
> +{
> +       platform_device_register_simple("sti-cpufreq", -1, NULL, 0);
> +}
> 

Can you please do this under drivers/cpufreq somewhere?

I really don't want to any more of these in platform code. Requiring a
device to be created just to probe the driver is really silly.

	Arnd
