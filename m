From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Jan 2013 19:11:32 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <50EC6CFF.5070309@arm.com>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1211061802240.21033@xanadu.home> <50EC6CFF.5070309@arm.com>
Message-ID: <201301081911.33089.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 January 2013, Jonathan Austin wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 335e220..0561d87 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -305,6 +305,11 @@ config ARCH_REALVIEW
>          help
>            This enables support for ARM Ltd RealView boards.
> 
> +config ARCH_VEXPRESS_NOMMU
> +       bool "ARM Ltd. Versatile Express family (nommu)"
> +       depends on !MMU
> +       select ARCH_VEXPRESS
> +
>   config ARCH_VERSATILE
>          bool "ARM Ltd. Versatile family"
>          select ARCH_WANT_OPTIONAL_GPIOLIB
> ---->8----

Yes, I think this is the right approach.

> With the other perhaps being to merge the ARCH_VEXPRESS option back in 
> to the 'choice' and create a ARCH_VEXPRESS_MULTI elsewhere...

That would needlessly break 'make oldconfig' for people that have
CONFIG_ARCH_VEXPRESS in their .config files or other scripts.

> Is that the sort of thing you had in mind, or is there another way 
> around that I'm missing?

I think it's good.

Acked-by: Arnd Bergmann <arnd@arndb.de>
