From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 30 Sep 2018 21:28:03 +0800
Subject: [PATCH V8 0/3] soc: imx: add scu firmware api support
In-Reply-To: <20180930072628.GN26692@dragon>
References: <1538268516-24678-1-git-send-email-aisheng.dong@nxp.com>
 <20180930072628.GN26692@dragon>
Message-ID: <20180930132759.GP26692@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2018 at 03:26:30PM +0800, Shawn Guo wrote:
> On Sun, Sep 30, 2018 at 08:48:33AM +0800, Dong Aisheng wrote:
> > Unlike the former i.MX Architectures, the new generation i.MX8 SoCs
> > (e.g. MX8QXP and MX8QM) contain a system controller which runs on a
> > dedicated Cortex-M core to provide power, clock, Pad, and resource
> > management. Communication between the host processor running
> > an OS and the system controller happens through a SCU protocol.
> > This patchset adds the SCU APIs which is implemented based on MU
> > and will be used by different system components.
> > 
> > It mainly consists of below parts:
> > 1) SCU IPC
> >    Basic IPC mechanism implemention based on mailbox which is used
> >    for communication between AP and SCU firmware.
> > 2) SCU IPC Service API
> > 
> > Dong Aisheng (3):
> >   dt-bindings: arm: fsl: add scu binding doc
> >   firmware: imx: add SCU firmware driver support
> >   firmware: imx: add misc svc support
> 
> Applied all, thanks.

I dropped the series for now because ...

> 
> > 
> >  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 183 ++++++
> >  drivers/firmware/Kconfig                           |   1 +
> >  drivers/firmware/Makefile                          |   1 +
> >  drivers/firmware/imx/Kconfig                       |  11 +
> >  drivers/firmware/imx/Makefile                      |   2 +
> >  drivers/firmware/imx/imx-scu.c                     | 270 +++++++++
> >  drivers/firmware/imx/misc.c                        |  99 ++++
> >  include/soc/imx/scu/ipc.h                          |  59 ++
> >  include/soc/imx/scu/sci.h                          |  17 +
> >  include/soc/imx/scu/svc/misc.h                     |  55 ++
> >  include/soc/imx/scu/types.h                        | 617 +++++++++++++++++++++

... I'm not sure the scu folder should be created under include/soc/imx/
or include/linux/firmware/imx/ like meson platform.  I would like to
hear more opinions.

Shawn
