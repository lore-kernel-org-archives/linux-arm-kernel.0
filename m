From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Mar 2013 09:52:47 +0800
Subject: [PATCH 2/4] ARM: imx: support DEBUG_LL uart port selection for
 all i.MX SoCs
In-Reply-To: <20130312143510.GA26044@magnum.frso.rivierawaves.com>
References: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
 <1355319945-3199-3-git-send-email-shawn.guo@linaro.org>
 <20130312143510.GA26044@magnum.frso.rivierawaves.com>
Message-ID: <20130313015246.GC27461@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 03:35:10PM +0100, Karl Beldan wrote:
> > -config DEBUG_IMX6Q_UART_PORT
> > -	int "i.MX6Q Debug UART Port (1-5)" if DEBUG_IMX6Q_UART
> > -	range 1 5
> > +config DEBUG_IMX_UART_PORT
> > +	int "i.MX Debug UART Port Selection" if DEBUG_IMX1_UART || \
> > +						DEBUG_IMX25_UART || \
> > +						DEBUG_IMX21_IMX27_UART || \
> > +						DEBUG_IMX31_UART || \
> > +						DEBUG_IMX35_UART || \
> > +						DEBUG_IMX51_UART || \
> > +						DEBUG_IMX50_IMX53_UART || \
> > +						DEBUG_IMX6Q_UART
> >  	default 1
> > -	depends on SOC_IMX6Q
> 
> After removing any dependency everybody gets a DEBUG_IMX_UART_PORT in
> their config now.
>  
Right, this is something undesirable.  Will fix it.  Thanks for
reporting, Karl.

Shawn
