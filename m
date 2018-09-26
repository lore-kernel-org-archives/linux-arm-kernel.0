From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 26 Sep 2018 12:02:25 +0000
Subject: [PATCh v3 1/4] arm64: add basic Kconfig symbols for i.MX8
In-Reply-To: <20180921125626.21971-1-l.stach@pengutronix.de>
References: <20180921125626.21971-1-l.stach@pengutronix.de>
Message-ID: <AM0PR04MB4211D28203CC397B48FB9D7980150@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 393d2b524284..210a0145117a 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -139,6 +139,20 @@ config ARCH_MVEBU
>  	   - Armada 7K SoC Family
>  	   - Armada 8K SoC Family
> 
> +config ARCH_MXC
> +	bool "ARMv8 based NXP i.MX SoC family"
> +	help
> +	  This enables support for the ARMv8 based SoCs in the
> +	  NXP i.MX family.
> +

A bit wondering whether we should depends on other platforms to select
the ones we need. But I did see similar users in kernel...

> +config SOC_IMX8MQ
> +	bool "i.MX8MQ support"
> +	depends on ARCH_MXC
> +	select ARM64_ERRATUM_843419
> +	select ARM64_ERRATUM_845719
> +	help
> +	  This enables support for the i.MX8MQ SoC.
> +

Do you think we need select some basic required configurations to make it
capable of booting? E.g. Pinctrl, Clock, Timer and etc...

Regards
Dong Aisheng

>  config ARCH_QCOM
>  	bool "Qualcomm Platforms"
>  	select GPIOLIB
> --
> 2.19.0
