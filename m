From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Aug 2012 09:20:52 +0000
Subject: [PATCH 2/3] ARM: PRIMA2: make mach-prima2 common for all SiRF
 series SoC
In-Reply-To: <CAGsJ_4yRbFrH8NPJZ6-gU1BebqVkQEBz_GLr4owQz+XpOyejug@mail.gmail.com>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
 <201208210757.32852.arnd@arndb.de>
 <CAGsJ_4yRbFrH8NPJZ6-gU1BebqVkQEBz_GLr4owQz+XpOyejug@mail.gmail.com>
Message-ID: <201208210920.52816.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 August 2012, Barry Song wrote:
> then i add these to Kconfig.debug as it is a common way
> 
>         config DEBUG_PRIMA2_UART1
>                 bool "Kernel low-level debugging on DaVinci DA8XX using UART1"
>                 depends on ARCH_PRIMA2
>                 help
>                   Say Y here if you want the debug print routines to direct
>                   their output to UART1 serial port on SiRFprimaII devices.
> 
>         config DEBUG_MARCO_UART1
>                 bool "Kernel low-level debugging on DaVinci DA8XX using UART2"
>                 depends on ARCH_MARCO
>                 help
>                   Say Y here if you want the debug print routines to direct
>                   their output to UART1 serial port on SiRFmarco devices.
> 
> and these in mach-prima2/include/mach/uart.h
> 
>   #ifdef CONFIG_DEBUG_PRIMA2_UART1
>   #define SIRFSOC_UART1_PA_BASE          0xb0060000
>   #elif defined(CONFIG_DEBUG_MARCO_UART1)
>   #define SIRFSOC_UART1_PA_BASE          0xcc060000
>   #endif
> 
> the above codes seem still ugly ?
> 

No, that's fine, about as a good as it gets with today's kernel
capabilities. Just fix the description to have the correct
SoC name instead of "DaVinci DA8XX" ;-)

	Arnd
