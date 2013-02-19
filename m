From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Feb 2013 22:07:31 +0000
Subject: [PATCH 10/35] mfd: ab8500-core: Rework MFD sub-device
 initialisation structures
In-Reply-To: <1360933026-30325-11-git-send-email-lee.jones@linaro.org>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
 <1360933026-30325-11-git-send-email-lee.jones@linaro.org>
Message-ID: <201302192207.31465.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013, Lee Jones wrote:
> +       {
> +               .name = "ab8500-charger",
> +               .of_compatible = "stericsson,ab8500-charger",
> +               .num_resources = ARRAY_SIZE(ab8500_charger_resources),
> +               .resources = ab8500_charger_resources,
> +#ifndef CONFIG_OF
> +               .platform_data = &ab8500_bm_data,
> +               .pdata_size = sizeof(ab8500_bm_data),
> +#endif
> +       },

Is this #ifdef correct? I would have expected "#ifdef CONFIG_ATAGS" here.

	Arnd
