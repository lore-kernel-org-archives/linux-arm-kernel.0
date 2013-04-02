From: eric@eukrea.com (Eric =?UTF-8?B?QsOpbmFyZA==?=)
Date: Tue, 2 Apr 2013 09:23:10 +0200
Subject: [PATCH] cpuimx27 and mbimx27: prepend CONFIG_ to Kconfig macro
In-Reply-To: <20130402071800.GI1906@pengutronix.de>
References: <1363911302.1390.167.camel@x61.thuisdomein>
 <20130402071800.GI1906@pengutronix.de>
Message-ID: <20130402092310.57307d13@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Le Tue, 2 Apr 2013 09:18:00 +0200,
Sascha Hauer <s.hauer@pengutronix.de> a ?crit :
> Any comment to this one? It looks like an obvious bugfix, but since this
> is quite old and was never noticed I wonder if there's something else
> wrong aswell?
> 
the patch seems OK.

Acked-by: Eric B?nard <eric@eukrea.com> 

Thanks,
Eric

> 
> On Fri, Mar 22, 2013 at 01:15:02AM +0100, Paul Bolle wrote:
> > Commit 2d66c7803595da0d4bcd949825d598575f5de9e6 ("cpuimx27 and mbimx27:
> > allow fine control of UART4 and SDHC2 usage") added the Kconfig symbol
> > MACH_EUKREA_CPUIMX27_USEUART4. But it forgot to prepend CONFIG_ to the
> > use of its macro. Add that prefix now.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > ---
> > Untested. This needs testing, obviously. Or a rethink, because these
> > typos have been in the tree since v2.6.36!
> > 
> >  arch/arm/mach-imx/eukrea_mbimx27-baseboard.c | 4 ++--
> >  arch/arm/mach-imx/mach-cpuimx27.c            | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> > index b4c7002..b2f08bf 100644
> > --- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> > +++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> > @@ -46,7 +46,7 @@ static const int eukrea_mbimx27_pins[] __initconst = {
> >  	PE10_PF_UART3_CTS,
> >  	PE11_PF_UART3_RTS,
> >  	/* UART4 */
> > -#if !defined(MACH_EUKREA_CPUIMX27_USEUART4)
> > +#if !defined(CONFIG_MACH_EUKREA_CPUIMX27_USEUART4)
> >  	PB26_AF_UART4_RTS,
> >  	PB28_AF_UART4_TXD,
> >  	PB29_AF_UART4_CTS,
> > @@ -306,7 +306,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
> >  
> >  	imx27_add_imx_uart1(&uart_pdata);
> >  	imx27_add_imx_uart2(&uart_pdata);
> > -#if !defined(MACH_EUKREA_CPUIMX27_USEUART4)
> > +#if !defined(CONFIG_MACH_EUKREA_CPUIMX27_USEUART4)
> >  	imx27_add_imx_uart3(&uart_pdata);
> >  #endif
> >  
> > diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
> > index 1465593..ea50870 100644
> > --- a/arch/arm/mach-imx/mach-cpuimx27.c
> > +++ b/arch/arm/mach-imx/mach-cpuimx27.c
> > @@ -48,7 +48,7 @@ static const int eukrea_cpuimx27_pins[] __initconst = {
> >  	PE14_PF_UART1_CTS,
> >  	PE15_PF_UART1_RTS,
> >  	/* UART4 */
> > -#if defined(MACH_EUKREA_CPUIMX27_USEUART4)
> > +#if defined(CONFIG_MACH_EUKREA_CPUIMX27_USEUART4)
> >  	PB26_AF_UART4_RTS,
> >  	PB28_AF_UART4_TXD,
> >  	PB29_AF_UART4_CTS,
> > @@ -272,7 +272,7 @@ static void __init eukrea_cpuimx27_init(void)
> >  	/* SDHC2 can be used for Wifi */
> >  	imx27_add_mxc_mmc(1, NULL);
> >  #endif
> > -#if defined(MACH_EUKREA_CPUIMX27_USEUART4)
> > +#if defined(CONFIG_MACH_EUKREA_CPUIMX27_USEUART4)
> >  	/* in which case UART4 is also used for Bluetooth */
> >  	imx27_add_imx_uart3(&uart_pdata);
> >  #endif
> > -- 
> > 1.7.11.7
> > 
> > 
> 
