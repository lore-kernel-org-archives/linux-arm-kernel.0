From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jan 2017 00:23:54 +0100
Subject: [PATCH 12/22] ARM: gemini: DT for the Cortina Gemini SoC platforms
In-Reply-To: <20170122122236.10665-1-linus.walleij@linaro.org>
References: <20170122122236.10665-1-linus.walleij@linaro.org>
Message-ID: <2789599.hfgAbXaEmE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, January 22, 2017 1:22:36 PM CET Linus Walleij wrote:
> +
> +/* Can we just use CONFIG_DEBUG_UART_PHYS and CONFIG_DEBUG_UART_VIRT? */
> +#define GEMINI_UART_BASE 0x42000000
> +#define GEMINI_UART_VBASE 0xf4200000
> +
> +/* This is needed for LL-debug/earlyprintk/debug-macro.S */
> +static struct map_desc gemini_io_desc[] __initdata = {
> +       {
> +               .virtual = GEMINI_UART_VBASE,
> +               .pfn = __phys_to_pfn(GEMINI_UART_BASE),
> +               .length = SZ_4K,
> +               .type = MT_DEVICE,
> +       },
> +};

I don't see why using CONFIG_DEBUG_UART_PHYS / CONFIG_DEBUG_UART_VIRT shouldn't
work here. Have you tried it?

	Arnd
