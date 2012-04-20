From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Apr 2012 13:30:17 +0800
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <20120418092019.GB2232@pengutronix.de>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <1332368519-22660-2-git-send-email-w.sang@pengutronix.de>
 <4F73CCC6.6000001@freescale.com>
 <20120329064320.GA20840@pengutronix.de>
 <20120418090551.GA30966@shlinux2.ap.freescale.net>
 <20120418092019.GB2232@pengutronix.de>
Message-ID: <20120420053014.GK22219@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 11:20:19AM +0200, Wolfram Sang wrote:
> > If not, i guess include/linux/fsl which already exists may be the
> > right place.
> 
> Which is a bad choice in my book. linux/dma would have been the proper
> thing for mxs-dma.h, I'd think.
> 
If it already exists, it will be the proper place.  We do not want to
be too invasive to create folders in include/linux for every subsystem
for only the need of fsl drivers.

On the other hand, I have seen a clear need for include/linux/fsl.
The following files are all good candidates to be moved there.

  include/linux/fsl_devices.h
  include/linux/fsl-diu-fb.h
  include/linux/fsl_hypervisor.h

IMO, include/linux/stmp_device.h is just another good candidate.

Oh, today I was asked by Fabio where is the good place for ssp-regs.h
which will be shared by mxs-mmc and spi-mxs, as we are cleaning up
<mach/*> from drivers.  I told him include/linux/fsl.

-- 
Regards,
Shawn
