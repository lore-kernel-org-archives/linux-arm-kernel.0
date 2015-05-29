From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 May 2015 14:53:25 +0200
Subject: [PATCH] ARM: lpc18xx: remove DEBUG_LL_UART_8250 from defconfig
In-Reply-To: <1432661986-4118-1-git-send-email-manabian@gmail.com>
References: <1432661986-4118-1-git-send-email-manabian@gmail.com>
Message-ID: <2264717.c7n5iR1HTW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 May 2015 19:39:46 Joachim Eastwood wrote:
> Please apply this to the next/defconfig branch.
> 
> After LPC18XX was converted to use the DEBUG_LPC18XX_UART0 config
> symbol there is now a mismatch in defconfig for this platform.
> 
> On a clean defconfig the following warnings appear.
> .config:2073:warning: symbol value '' invalid for DEBUG_UART_PHYS
> .config:2074:warning: symbol value '' invalid for DEBUG_UART_VIRT
> 
> Since the default value now depends on DEBUG_LPC18XX_UART0 and not
> ARCH_LPC18XX.
> 

Applied now, thanks a lot!

I missed this problem because I'm mainly testing with a branch that
has a workaround for the general problem of DEBUG_UART_PHYS being
empty.

	Arnd
