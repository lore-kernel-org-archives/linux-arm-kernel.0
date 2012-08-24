From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 24 Aug 2012 14:01:32 -0600
Subject: [RFC PATCH] ARM: initial multiplatform support
In-Reply-To: <1345837852-10277-1-git-send-email-robherring2@gmail.com>
References: <1345837852-10277-1-git-send-email-robherring2@gmail.com>
Message-ID: <5037DD9C.2090403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2012 01:50 PM, Rob Herring wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This lets us build a multiplatform kernel for experimental purposes.
> However, it will not be useful for any real work, because it relies
> on a number of useful things to be disabled for now:
...

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig

> +config ARCH_SOCFPGA_CHOICE
> +	bool "Altera SOCFPGA family"
> +	select ARCH_SOCFPGA

> -config ARCH_VEXPRESS
> +config ARCH_VEXPRESS_CHOICE
...
> +	select ARCH_VEXPRESS

> -config ARCH_HIGHBANK
> +config ARCH_HIGHBANK_CHOICE
...
>  	help

Doesn't that need "select ARCH_HIGHBANK" too?

I see Tegra doesn't work with SPARSE_IRQ:-( I'll have to look into
what's required to make that work...
