From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 30 Sep 2018 15:26:30 +0800
Subject: [PATCH V8 0/3] soc: imx: add scu firmware api support
In-Reply-To: <1538268516-24678-1-git-send-email-aisheng.dong@nxp.com>
References: <1538268516-24678-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180930072628.GN26692@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2018 at 08:48:33AM +0800, Dong Aisheng wrote:
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
> 
> Dong Aisheng (3):
>   dt-bindings: arm: fsl: add scu binding doc
>   firmware: imx: add SCU firmware driver support
>   firmware: imx: add misc svc support

Applied all, thanks.

> 
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 183 ++++++
>  drivers/firmware/Kconfig                           |   1 +
>  drivers/firmware/Makefile                          |   1 +
>  drivers/firmware/imx/Kconfig                       |  11 +
>  drivers/firmware/imx/Makefile                      |   2 +
>  drivers/firmware/imx/imx-scu.c                     | 270 +++++++++
>  drivers/firmware/imx/misc.c                        |  99 ++++

Can you create another patch adding drivers/firmware/imx/ into
MAINTAINER under IMX architecture?

Shawn

>  include/soc/imx/scu/ipc.h                          |  59 ++
>  include/soc/imx/scu/sci.h                          |  17 +
>  include/soc/imx/scu/svc/misc.h                     |  55 ++
>  include/soc/imx/scu/types.h                        | 617 +++++++++++++++++++++
>  11 files changed, 1315 insertions(+)
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
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
