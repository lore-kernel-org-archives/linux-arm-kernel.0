From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 24 Jan 2018 23:28:12 +0000
Subject: [PATCH v2 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
In-Reply-To: <20180123083823.GB21463@kroah.com>
References: <1516220434-22204-1-git-send-email-jollys@xilinx.com>
 <1516220434-22204-3-git-send-email-jollys@xilinx.com>
 <20180123083823.GB21463@kroah.com>
Message-ID: <DM2PR0201MB076771C6652E5D19A803D66DB8E20@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for review Greg,

> -----Original Message-----
> From: Greg KH [mailto:gregkh at linuxfoundation.org]
> Sent: Tuesday, January 23, 2018 12:38 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel at linaro.org; mingo at kernel.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; michal.simek at xilinx.com; robh+dt at kernel.org;
> mark.rutland at arm.com; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v2 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
> driver
> 
> On Wed, Jan 17, 2018 at 12:20:32PM -0800, Jolly Shah wrote:
> > This patch is adding communication layer with firmware.
> > Firmware driver provides an interface to firmware APIs.
> > Interface APIs can be used by any driver to communicate to
> > PMUFW(Platform Management Unit). All requests go through ATF.
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > ---
> >  arch/arm64/Kconfig.platforms                    |   1 +
> >  drivers/firmware/Kconfig                        |   1 +
> >  drivers/firmware/Makefile                       |   1 +
> >  drivers/firmware/xilinx/Kconfig                 |   4 +
> >  drivers/firmware/xilinx/Makefile                |   4 +
> >  drivers/firmware/xilinx/zynqmp/Kconfig          |  16 +
> >  drivers/firmware/xilinx/zynqmp/Makefile         |   4 +
> >  drivers/firmware/xilinx/zynqmp/firmware.c       | 987
> ++++++++++++++++++++++++
> >  include/linux/firmware/xilinx/zynqmp/firmware.h | 570 ++++++++++++++
> 
> Why does this file need to be in include/linux/ at all?  Shouldn't it just live in the
> driver-specific subdir?
> 
> thanks,
> 
> greg k-h

It is used by multiple drivers so can not live in driver specific subdir.

Thanks,
Jolly Shah
