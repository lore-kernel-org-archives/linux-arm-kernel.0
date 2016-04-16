From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Apr 2016 22:01:05 +0200
Subject: [PATCH] bus: brcmstb_gisb: Rework dependencies
In-Reply-To: <1460571469-20201-1-git-send-email-f.fainelli@gmail.com>
References: <1460571469-20201-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <13932531.o87aikNi0r@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 April 2016 11:17:48 Florian Fainelli wrote:
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -58,6 +58,8 @@ config ARM_CCN
>  config BRCMSTB_GISB_ARB
>         bool "Broadcom STB GISB bus arbiter"
>         depends on ARM || MIPS
> +       default ARCH_BRCMSTB
> +       default BMIPS_GENERIC
> 

I think having two 'default' statements is not clear to human
readers, how about changing it to

	default ARCH_BRCMSTB || BMIPS_GENERIC


	Arnd
