From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Apr 2012 16:06:05 +0200
Subject: [PATCH 34/40] ARM: imx6: implement clocks using common clock
 framework
In-Reply-To: <20120419135628.GB22219@S2101-09.ap.freescale.net>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-35-git-send-email-s.hauer@pengutronix.de>
 <20120418113355.GO20478@pengutronix.de>
 <20120419135628.GB22219@S2101-09.ap.freescale.net>
Message-ID: <20120419140605.GL3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 09:56:32PM +0800, Shawn Guo wrote:
> On Wed, Apr 18, 2012 at 01:33:55PM +0200, Sascha Hauer wrote:
> > Hi Shawn,
> > 
> > > +
> > > +static const char * const clks_init_on[] __initconst = {
> > > +	"mmdc_ch0_axi", "mmdc_ch1_axi", "uart_ipg", "uart_serial",
> > > +};
> > 
> > I assume uart_ipg and uart_serial is here for the earlyprintk case. This
> > is not needed anymore. earlyprintk depends on an enabled uart anyway, so
> > we can safely assume that the clock is turned on when Linux starts. The
> > clock framework will disable the clock in a late initcall, long after
> > the real driver has taken over and enabled the clock.
> > 
> Yes, that's the case for the last 2 clocks, but the first 2 clocks are
> for memory and need to be kept there.  Also, currently I do not have
> uart_ipg in the clkdev for uart driver to look up, so if we remove it
> from clks_init_on, we need to add it into clkdev.

Yes, I already fixed up the uart clocks.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
