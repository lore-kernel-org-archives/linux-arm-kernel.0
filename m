From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 31 Aug 2013 08:29:37 +0200
Subject: [PATCH v2 4/7] ARM: dts: imx27 pinctrl
In-Reply-To: <20130820071411.GI31036@pengutronix.de>
References: <1376921234-26682-1-git-send-email-mpa@pengutronix.de>
 <1376921234-26682-5-git-send-email-mpa@pengutronix.de>
 <20130820071411.GI31036@pengutronix.de>
Message-ID: <20130831062937.GU20071@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Aug 20, 2013 at 09:14:11AM +0200, Sascha Hauer wrote:
> On Mon, Aug 19, 2013 at 04:07:11PM +0200, Markus Pargmann wrote:
> > Pinctrl driver node and pin group definitions for other driver nodes.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> > +					pinctrl_uart_1: uart-1 {
> > +						fsl,pins = <
> > +							MX27_PAD_UART1_TXD__UART1_TXD 0x0
> > +							MX27_PAD_UART1_RXD__UART1_RXD 0x0
> > +							MX27_PAD_UART1_CTS__UART1_CTS 0x0
> > +							MX27_PAD_UART1_RTS__UART1_RTS 0x0
> > +						>;
> > +					};
> 
> The above either misses a group number or an uart number. We need
> pinctrl_uart<uartno>_<groupno>

Fixed.

> 
> Also this doesn't scale very good. For boards without RTS/CTS we would have
> to add a completely different group. For the FEC I've seen different
> groups with a dozen pins each which differ in only a single pin.
> 
> I therefore suggest (and Shawn acked the general idea already) to
> do this:
> 
> 	pinctrl_uart1_1: uart1-1 {
> 		fsl,pins = <
> 			MX27_PAD_UART1_TXD__UART1_TXD 0x0
> 			MX27_PAD_UART1_RXD__UART1_RXD 0x0
> 		>;
> 	};
> 
> 	pinctrl_uart1_rtscts_1: uart1-rtscts-1 {
> 		fsl,pins = <
> 			MX27_PAD_UART1_CTS__UART1_CTS 0x0
> 			MX27_PAD_UART1_RTS__UART1_RTS 0x0
> 		>;
> 	};

I changed the uart groups accordingly.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
