From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Dec 2014 23:35:17 +0100
Subject: [PATCH 1/4] ARM: sirf: add two debug ports for CSRatlas7 SoC
In-Reply-To: <1419496460-4929-2-git-send-email-21cnbao@gmail.com>
References: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
 <1419496460-4929-2-git-send-email-21cnbao@gmail.com>
Message-ID: <88770560.BUUQRjmk3f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 December 2014 16:34:17 Barry Song wrote:
>  #if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
> -#define SIRFSOC_UART1_PA_BASE          0xb0060000
> +#define SIRF_LLUART_PA_BASE          0xb0060000
>  #elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
> -#define SIRFSOC_UART1_PA_BASE          0xcc060000
> +#define SIRF_LLUART_PA_BASE          0xcc060000
> +#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART1)
> +#define SIRF_LLUART_PA_BASE          0x18020000
> +#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART0)
> +#define SIRF_LLUART_PA_BASE          0x18010000
>  #else
> -#define SIRFSOC_UART1_PA_BASE          0
> +#define SIRF_LLUART_PA_BASE          0
>  #endif

I think it would be nicer to use DEBUG_UART_PHYS/DEBUG_UART_VIRT here.

	Arnd
