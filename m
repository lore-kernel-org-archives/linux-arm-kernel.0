From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 24 Aug 2018 07:36:38 +0000
Subject: [PATCH V5 0/5] soc: imx: add scu firmware api support
In-Reply-To: <AM0PR04MB4211F68CCD399243613F8D7B80320@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211F68CCD399243613F8D7B80320@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB4211F748DBD1FE64A2B2136980360@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi & Sasha,

Do you have some suggestions about this patch series?

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Tuesday, August 21, 2018 12:32 AM
> To: Jassi Brar <jassisinghbrar@gmail.com>; Sascha Hauer
> <s.hauer@pengutronix.de>
> Cc: dongas86 at gmail.com; kernel at pengutronix.de; shawnguo at kernel.org;
> Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH V5 0/5] soc: imx: add scu firmware api support
> 
> Hi Jassi & Sascha,
> 
> Would you help review this new version patch series?
> 
> It's changed to generic MU driver using 8 separately MU channels according to
> Jassi's suggestion.
> Please help check if this is okay to you.
> 
> Regards
> Dong Aisheng
> 
> > -----Original Message-----
> > From: A.s. Dong
> > Sent: Tuesday, August 21, 2018 12:08 AM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: dongas86 at gmail.com; kernel at pengutronix.de; shawnguo at kernel.org;
> > Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx <linux-
> > imx at nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > Subject: [PATCH V5 0/5] soc: imx: add scu firmware api support
> >
> > Unlike the former i.MX Architectures, the new generation i.MX8 SoCs (e.g.
> > MX8QXP and MX8QM) contain a system controller which runs on a
> > dedicated Cortex-M core to provide power, clock, Pad, and resource
> management.
> > Communication between the host processor running an OS and the system
> > controller happens through a SCU protocol.
> > This patchset adds the SCU APIs which is implemented based on MU and
> > will be used by different system components.
> >
> > It mainly consists of below parts:
> > 1) SCU IPC
> >    Basic IPC mechanism implemention based on mailbox which is used
> >    for communication between AP and SCU firmware.
> > 2) SCU IPC Service API
> >
> > Dong Aisheng (5):
> >   dt-bindings: arm: fsl: add scu binding doc
> >   soc: imx: add SC firmware IPC and APIs
> >   soc: imx: sc: add pm svc support
> >   soc: imx: sc: add pad svc support
> >   soc: imx: sc: add misc svc support
> >
> >  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 179 ++++++
> >  drivers/soc/imx/Kconfig                            |   4 +
> >  drivers/soc/imx/Makefile                           |   1 +
> >  drivers/soc/imx/sc/Makefile                        |   5 +
> >  drivers/soc/imx/sc/main/ipc.c                      | 258 +++++++++
> >  drivers/soc/imx/sc/main/rpc.h                      |  51 ++
> >  drivers/soc/imx/sc/svc/misc/rpc_clnt.c             | 106 ++++
> >  drivers/soc/imx/sc/svc/pad/rpc_clnt.c              |  82 +++
> >  drivers/soc/imx/sc/svc/pm/rpc_clnt.c               | 275 +++++++++
> >  include/soc/imx/sc/ipc.h                           |  46 ++
> >  include/soc/imx/sc/sci.h                           |  20 +
> >  include/soc/imx/sc/svc/misc/api.h                  |  60 ++
> >  include/soc/imx/sc/svc/pad/api.h                   |  60 ++
> >  include/soc/imx/sc/svc/pm/api.h                    | 229 ++++++++
> >  include/soc/imx/sc/types.h                         | 636
> +++++++++++++++++++++
> >  15 files changed, 2012 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> >  create mode 100644 drivers/soc/imx/sc/Makefile  create mode 100644
> > drivers/soc/imx/sc/main/ipc.c  create mode 100644
> > drivers/soc/imx/sc/main/rpc.h  create mode 100644
> > drivers/soc/imx/sc/svc/misc/rpc_clnt.c
> >  create mode 100644 drivers/soc/imx/sc/svc/pad/rpc_clnt.c
> >  create mode 100644 drivers/soc/imx/sc/svc/pm/rpc_clnt.c
> >  create mode 100644 include/soc/imx/sc/ipc.h  create mode 100644
> > include/soc/imx/sc/sci.h  create mode 100644
> > include/soc/imx/sc/svc/misc/api.h  create mode 100644
> > include/soc/imx/sc/svc/pad/api.h  create mode 100644
> > include/soc/imx/sc/svc/pm/api.h  create mode 100644
> > include/soc/imx/sc/types.h
> >
> > --
> > 2.7.4
