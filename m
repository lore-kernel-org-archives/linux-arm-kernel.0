From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 22 Dec 2010 10:10:50 +0800
Subject: [PATCH] ARM: mxs: Change duart device to use amba-pl011
In-Reply-To: <20101221203121.GB31617@pengutronix.de>
References: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
	<1292937130-32155-1-git-send-email-shawn.guo@freescale.com>
	<20101221203121.GB31617@pengutronix.de>
Message-ID: <20101222021049.GI16497@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thanks for the review.

On Tue, Dec 21, 2010 at 09:31:21PM +0100, Wolfram Sang wrote:
> Hi Shawn,
> 
> On Tue, Dec 21, 2010 at 09:12:10PM +0800, Shawn Guo wrote:
> > The mxs duart is actually an amba-pl011 device. This commit changes
> > the duart device code to dynamically allocate amba-pl011 device,
> > so that drivers/serial/amba-pl011.c can be used on mxs.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Great that it works!
> 
[...]
> >  static struct clk_lookup lookups[] = {
> > -	_REGISTER_CLOCK("mxs-duart.0", NULL, uart_clk)
> > +	_REGISTER_CLOCK("uart", NULL, uart_clk)
> 
> Maybe "duart"?
> 
I was thinking about the naming "uart" vs "duart" here, and decided to
pick the "uart", because this is the name of clock "uart_clk", which
is the clock for uart domain, not only duart.

[...]

> > +#include <mach/mx23.h>
> > +#include <mach/mx28.h>
> > +#include <mach/devices-common.h>
> > +
> > +#define MXS_AMBA_DEVICE(name, soc)				\
> 
> Maybe MXS_AMBA_DUART_DEVICE? It now sounds more generic than it actually is ;)
> 
OK. Will change.

-- 
Regards,
Shawn
