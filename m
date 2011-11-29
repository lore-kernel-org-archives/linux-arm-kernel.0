From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Nov 2011 09:13:40 -0500 (EST)
Subject: [PATCH] ARM: u300: delete memory.h
In-Reply-To: <1322574769-20453-1-git-send-email-linus.walleij@stericsson.com>
References: <1322574769-20453-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <alpine.LFD.2.02.1111290912030.2060@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Nov 2011, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Last merge window the memory maps for U300 were simplified so
> we can now safely delete memory.h.
> 
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/Kconfig                         |    2 +-
>  arch/arm/mach-u300/include/mach/memory.h |   19 -------------------
>  arch/arm/mach-u300/u300.c                |    2 +-
>  3 files changed, 2 insertions(+), 21 deletions(-)
>  delete mode 100644 arch/arm/mach-u300/include/mach/memory.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 44789ef..3ce67eb 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -892,7 +892,7 @@ config ARCH_U300
>  	select HAVE_MACH_CLKDEV
>  	select GENERIC_GPIO
>  	select ARCH_REQUIRE_GPIOLIB
> -	select NEED_MACH_MEMORY_H
> +	select NO_MACH_MEMORY_H

you don't have to select anything when removing NEED_MACH_MEMORY_H.

With that removed:

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
