From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 4 Jun 2012 10:19:37 +0200
Subject: Freescale fec.c driver breakage
In-Reply-To: <4FCC3CB4.5030107@snapgear.com>
References: <4FCC3CB4.5030107@snapgear.com>
Message-ID: <20120604081937.GH30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Mon, Jun 04, 2012 at 02:42:28PM +1000, Greg Ungerer wrote:
> 
> Hi Sascha,
> 
> Commit f4d40de39a23f0c39cca55ac63e1175c69c3d2f7 ("net fec: do not
> depend on grouped clocks") breaks compilation of the FEC driver for
> non iMX platforms in linux-3.5-rc1. For example when compiling for
> ColdFire I get:
> 
> 	  LD      vmlinux
>     drivers/built-in.o: In function `fec_probe':
>     fec.c:(.devinit.text+0x1e0): undefined reference to `devm_clk_get'

Sorry, I forgot that this driver is used on coldfire.

> 
> Trivially we could conditionalize the code block that calls
> devm_clk_get() in the probe routine, but that is kind of ugly.

It's ugly, but the only other solution I see is that you could provide a
dummy devm_clk_get() for coldfire. Added Mark to Cc, maybe he has
another idea?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
