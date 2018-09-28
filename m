From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 28 Sep 2018 08:12:23 +0200
Subject: [PATCH V7 0/3] soc: imx: add scu firmware api support
In-Reply-To: <1537892878-30933-1-git-send-email-aisheng.dong@nxp.com>
References: <1537892878-30933-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180928061223.dghtovm7kgcjhc4w@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

On Wed, Sep 26, 2018 at 12:27:55AM +0800, Dong Aisheng wrote:
> Unlike the former i.MX Architectures, the new generation i.MX8 SoCs
> (e.g. MX8QXP and MX8QM) contain a system controller which runs on a
> dedicated Cortex-M core to provide power, clock, Pad, and resource
> management. Communication between the host processor running
> an OS and the system controller happens through a SCU protocol.
> This patchset adds the SCU APIs which is implemented based on MU
> and will be used by different system components.
> 
> It mainly consists of below parts:
> 1) SCU IPC
>    Basic IPC mechanism implemention based on mailbox which is used
>    for communication between AP and SCU firmware.
> 2) SCU IPC Service API

Still some imx_sc_ prefixes missing. Otherwise looks good to me now,
so

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> Dong Aisheng (3):
>   dt-bindings: arm: fsl: add scu binding doc
>   firmware: imx: add SCU firmware driver support
>   firmware: imx: add misc svc support
> 
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 183 ++++++
>  drivers/firmware/Kconfig                           |   1 +
>  drivers/firmware/Makefile                          |   1 +
>  drivers/firmware/imx/Kconfig                       |  11 +
>  drivers/firmware/imx/Makefile                      |   2 +
>  drivers/firmware/imx/imx-scu.c                     | 224 ++++++++
>  drivers/firmware/imx/misc.c                        | 110 ++++
>  include/soc/imx/scu/ipc.h                          |  59 ++
>  include/soc/imx/scu/sci.h                          |  17 +
>  include/soc/imx/scu/svc/misc.h                     |  55 ++
>  include/soc/imx/scu/types.h                        | 636 +++++++++++++++++++++
>  11 files changed, 1299 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>  create mode 100644 drivers/firmware/imx/Kconfig
>  create mode 100644 drivers/firmware/imx/Makefile
>  create mode 100644 drivers/firmware/imx/imx-scu.c
>  create mode 100644 drivers/firmware/imx/misc.c
>  create mode 100644 include/soc/imx/scu/ipc.h
>  create mode 100644 include/soc/imx/scu/sci.h
>  create mode 100644 include/soc/imx/scu/svc/misc.h
>  create mode 100644 include/soc/imx/scu/types.h
> 
> -- 
> 2.7.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
