From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 10:18:54 +0000
Subject: [PATCH 2/3] ARM: ux500: Turn on the 'heartbeat' LED trigger
In-Reply-To: <1357725965-27342-2-git-send-email-lee.jones@linaro.org>
References: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
 <1357725965-27342-2-git-send-email-lee.jones@linaro.org>
Message-ID: <201301091018.55058.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013, Lee Jones wrote:
> diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> index 5dea906..0f25b07 100644
> --- a/arch/arm/mach-ux500/Kconfig
> +++ b/arch/arm/mach-ux500/Kconfig
> @@ -43,6 +43,8 @@ config MACH_HREFV60
>  config MACH_SNOWBALL
>         bool "U8500 Snowball platform"
>         select MACH_MOP500
> +       select LEDS_TRIGGERS
> +       select LEDS_TRIGGER_HEARTBEAT
>         help
>           Include support for the snowball development platform.

Be careful with "select" statements like this when there are other
dependencies. I think LEDS_TRIGGERS depends on LEDS_CLASS, so this
should probably be written as

	select LEDS_TRIGGERS if LEDS_CLASS

	Arnd
