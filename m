From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 31 Dec 2014 16:31:05 +0100
Subject: [PATCH 1/4] ARM: sirf: add two debug ports for CSRatlas7 SoC
In-Reply-To: <CAGsJ_4wUO6rOW4ZyciXkdKtZjkbdHyo=je7_20B5kumKnu8m9A@mail.gmail.com>
References: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
 <88770560.BUUQRjmk3f@wuerfel>
 <CAGsJ_4wUO6rOW4ZyciXkdKtZjkbdHyo=je7_20B5kumKnu8m9A@mail.gmail.com>
Message-ID: <43053389.8mSSmmg5HD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 December 2014 23:05:44 Barry Song wrote:
> 2014-12-31 6:35 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday 25 December 2014 16:34:17 Barry Song wrote:
> >>  #if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
> >> -#define SIRFSOC_UART1_PA_BASE          0xb0060000
> >> +#define SIRF_LLUART_PA_BASE          0xb0060000
> >>  #elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
> >> -#define SIRFSOC_UART1_PA_BASE          0xcc060000
> >> +#define SIRF_LLUART_PA_BASE          0xcc060000
> >> +#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART1)
> >> +#define SIRF_LLUART_PA_BASE          0x18020000
> >> +#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART0)
> >> +#define SIRF_LLUART_PA_BASE          0x18010000
> >>  #else
> >> -#define SIRFSOC_UART1_PA_BASE          0
> >> +#define SIRF_LLUART_PA_BASE          0
> >>  #endif
> >
> > I think it would be nicer to use DEBUG_UART_PHYS/DEBUG_UART_VIRT here.
> 
> yes if it is more general name for all. my second feeling is that does
> this conflict CSR namespace stuff into high-level and common namespace
> things?

I think my comment was misleading. What I meant was to use
CONFIG_DEBUG_UART_PHYS from arch/arm/Kconfig.debug the same way
we do for the 8250 and pl011 compatible uarts.

	Arnd
