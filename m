From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Mar 2016 17:31:44 +0100
Subject: [PATCH] ARM: at91: avoid defining CONFIG_* symbols in source code
In-Reply-To: <56D70ADB.2050008@atmel.com>
References: <1456238384-882646-1-git-send-email-arnd@arndb.de>
 <56D70ADB.2050008@atmel.com>
Message-ID: <2506540.Af9r4eEVXL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2016 16:46:35 Nicolas Ferre wrote:
> Le 23/02/2016 15:39, Arnd Bergmann a ?crit :
> > In an invalid randconfig build (fixed by another patch),
> > I ran across this warning:
> > 
> > arch/arm/include/debug/at91.S:18:0: error: "CONFIG_DEBUG_UART_VIRT" redefined [-Werror]
> >  #define CONFIG_DEBUG_UART_VIRT AT91_IO_P2V(CONFIG_DEBUG_UART_PHYS)
> > 
> > As Russell pointed out, we should never #define a macro starting
> > with CONFIG_ in a source file, as that is rather confusing.
> > 
> > This renames the macro to avoid the symbol clash.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Suggested-by: Russell King <linux@arm.linux.org.uk>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Arnd,
> 
> Can you please add this patch on top of the arm-soc branches "soc" or
> "cleanup" for 4.6.
> I don't think that we will have more material for these branches to send
> to you before the opening of the merge window.
> 
> Thanks for your patch, bye.

Applied to next/soc, thanks!

	Arnd
