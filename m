From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Apr 2015 11:41:48 +0200
Subject: [PATCH 1/4] ARM: UniPhier: add basic support for UniPhier
 architecture
In-Reply-To: <1429170038-16757-2-git-send-email-yamada.masahiro@socionext.com>
References: <1429170038-16757-1-git-send-email-yamada.masahiro@socionext.com>
 <1429170038-16757-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <3655031.20bjeBBBYS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 April 2015 16:40:35 Masahiro Yamada wrote:

>+ENTRY(uniphier_secondary_startup)
>+       bl      v7_invalidate_l1
>+       b       secondary_startup
>+ENDPROC(uniphier_secondary_startup)

Since this file is really trivial, I wonder if you could just use
a 'naked' inline assembly function from C code here, to have
the entire SMP support in one file.

> +
> +#define ROM_BOOT_ROMRSV2		0x59801208

Please don't hardcode any physical addresses, instead find the DT node
or syscon device in the _boot_secondary implementation.


Which device is this register part of?

> +
> +static const char * const uniphier_board_dt_compat[] __initconst = {
> +	"socionext,ph1-sld3",
> +	"socionext,ph1-ld4",
> +	"socionext,ph1-pro4",
> +	"socionext,ph1-sld8",
> +	"socionext,ph1-pro5",
> +	"socionext,ph1-proxstream2",
> +	"socionext,ph1-ld6b",
> +	NULL,
> +};

Are these chip names or board names? The list should normally have
just the socs, which I assume you do, but it's not completely clear
from the source.

	Arnd
