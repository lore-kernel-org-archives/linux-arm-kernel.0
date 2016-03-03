From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 13:56:56 +0100
Subject: [PATCH 12/17] arm: Add new mach-oxnas
In-Reply-To: <1457005210-18485-13-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-13-git-send-email-narmstrong@baylibre.com>
Message-ID: <3226743.49AyJYeiGh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 12:40:05 Neil Armstrong wrote:
> +
> +config MACH_OX810SE
> +	bool "Support OX810SE Based Products"
> +	select CPU_ARM926T
> +	select PLXTECH_RPS
> +	select CLKSRC_RPS_TIMER
> +	select RESET_OXNAS
> +	select COMMON_CLK_OXNAS
> +	select PINCTRL_OXNAS

Please sort these alphabetically

> +
> +static void __init oxnas_init(void)
> +{
> +	pr_info("OXNAS Device Tree boot\n");
> +
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

I think you should at least remove this function, as the pr_info is not
needed and the rest is the default.

As Russell mentioned, the entire file is not really needed either, but
so far we have left the trivial per-platform files in place generally.

	Arnd
