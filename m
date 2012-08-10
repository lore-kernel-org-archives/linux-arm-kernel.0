From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 10 Aug 2012 21:56:38 +0200
Subject: Lockups reading from i.MX51 SSI registers
In-Reply-To: <20120810195005.GP24328@opensource.wolfsonmicro.com>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
Message-ID: <20120810195638.GF1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 08:50:08PM +0100, Mark Brown wrote:
> Hi,
> 
> I'm trying to use -next to test AC'97 register I/O on an i.MX51 board
> but I'm seeing the CPU hang during probe at:
> 
> 	lreg = (reg & 0x7f) <<  12 ;
> 	writel(lreg, base + SSI_SACADD);
> 
> in imx_ssi_ac97_read().  I'm somewhat suspicious this might be because
> the IP block isn't clocked properly, I do notice the recent conversion
> to the clock API which looks rather involved but it's possible something
> else broke.  Does anyone have any bright ideas what might be going on
> here?  The board doesn't have the reste functions defined so this is the
> first interaction with the hardware block AFAICT.

No idea currently, just adding Uwe to Cc because I think he has seen
something similar on an i.MX35 board recently.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
