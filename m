From: B39297@freescale.com (Wu Guoxing-B39297)
Date: Thu, 10 Nov 2011 11:38:36 +0000
Subject: [PATCH v4] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <20111110110914.GD2503@pengutronix.de>
References: <1320891899-16135-1-git-send-email-b39297@freescale.com>
 <4EBBA3D6.9000300@pengutronix.de> <20111110102037.GC2503@pengutronix.de>
 <3D55990BDF4852409EA769663F22E54AC182CF@039-SN1MPN1-006.039d.mgd.msft.net>
 <20111110110914.GD2503@pengutronix.de>
Message-ID: <3D55990BDF4852409EA769663F22E54AC1830A@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram & Marc:
  I sent out the v6 patch to remove this from both probe and remove functions
Also, in remove function, changed to return the error code.

  Please review the V6 patch.

  Thanks for the comments!

Best Regards
Wu Guoxing

-----Original Message-----
From: Wolfram Sang [mailto:w.sang at pengutronix.de] 
Sent: Thursday, November 10, 2011 7:09 PM
To: Wu Guoxing-B39297
Cc: Marc Kleine-Budde; grant.likely at secretlab.ca; s.hauer at pengutronix.de; shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH v4] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function

>   I changed the code to unset i2c client data just when 
> gipochip_remove successes, Otherwise, there will be problems next time the remove function is called.

The i2c-core will do it on probe-failure and on remove. Check e4a7b9b0.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
