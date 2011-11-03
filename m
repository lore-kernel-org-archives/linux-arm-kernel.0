From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Nov 2011 12:30:17 +0100
Subject: [PATCH] ARM : mx35: 3ds-board: add framebuffer device
In-Reply-To: <3D55990BDF4852409EA769663F22E54AC0424A@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1320299797-23167-1-git-send-email-b39297@freescale.com>
	<20111103071824.GB16886@pengutronix.de>
	<3D55990BDF4852409EA769663F22E54AC0424A@039-SN1MPN1-006.039d.mgd.msft.net>
Message-ID: <20111103113017.GG16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2011 at 08:02:11AM +0000, Wu Guoxing-B39297 wrote:
> Hi Sascha:
>   The mc9s08dz60 is a MCU, and its function depend on the code flashed
>   in it. so, it is not a common chip.  it is only for mx35 3ds board,
>   a driver for it will be useless for others, that's why I didn't
>   write a common driver for it, as it will never be used in any other
>   freescale board. But, if you insist, I will write a driver for it.

Yes, please write a driver for it. You don't have to write a full
featured driver, gpio access is enough. Normally you should write a mfd
driver, but I think for now you can just put the i2c glue into
drivers/gpio/mc9s08dz60.c

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
