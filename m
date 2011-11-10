From: B39297@freescale.com (Wu Guoxing-B39297)
Date: Thu, 10 Nov 2011 11:06:13 +0000
Subject: [PATCH v4] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <20111110102037.GC2503@pengutronix.de>
References: <1320891899-16135-1-git-send-email-b39297@freescale.com>
 <4EBBA3D6.9000300@pengutronix.de> <20111110102037.GC2503@pengutronix.de>
Message-ID: <3D55990BDF4852409EA769663F22E54AC182CF@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:

  I changed the code to unset i2c client data just when gipochip_remove successes,
Otherwise, there will be problems next time the remove function is called.

  Please review the v5 patch.

  Thanks!

Best Regards
Wu Guoxing

-----Original Message-----
From: Wolfram Sang [mailto:w.sang at pengutronix.de] 
Sent: Thursday, November 10, 2011 6:21 PM
To: Marc Kleine-Budde
Cc: Wu Guoxing-B39297; grant.likely at secretlab.ca; s.hauer at pengutronix.de; shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH v4] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function

On Thu, Nov 10, 2011 at 11:13:42AM +0100, Marc Kleine-Budde wrote:
> On 11/10/2011 03:24 AM, wu guoxing wrote:
> > we only use the gpio function of mc9s08dz60 mcu chip, so just add 
> > the gpio driver, as this mcu will never be used in other board.
> > 
> > Signed-off-by: Wu Guoxing <b39297@freescale.com>
> > ---
> > changes since v3:
> > 	1. set i2c client data before gpiochip_add
> 
> exchange the two in the remove function, too.
> First shut down the gpio chip, then unset set i2c client data.

and don't set clientdata to NULL.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
