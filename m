From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 1 May 2018 08:03:30 +0200
Subject: [PATCH 00/12] clk: imx: add imx8qxp clock support
In-Reply-To: <1524855403-15301-1-git-send-email-aisheng.dong@nxp.com>
References: <1524855403-15301-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180501060330.l5j6rztqal2whgge@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

same functionality is actually needed on iMX7d and many other non NXP
socs.
IMO proper solution is to introduce generic clock proxy or some thing
like this on top of rpmsg/virtio 

On Sat, Apr 28, 2018 at 02:56:31AM +0800, Dong Aisheng wrote:
> This patch series adds i.MX8QXP clock support which is based
> on the clock service provided by SCU firmware.
> It depends on SCU APIs patch set.
> 
> Dong Aisheng (12):
>   clk: imx: add configuration option for mmio clks
>   clk: imx: scu: add scu clock common part
>   clk: imx: scu: add scu clock divider
>   clk: imx: scu: add scu clock gpr divider
>   clk: imx: scu: add scu clock gate
>   clk: imx: scu: add scu clock gpr gate
>   clk: imx: scu: add scu clock mux
>   clk: imx: scu: add scu clock gpr mux
>   clk: imx: add common imx_clk_hw_fixed functions
>   clk: imx: add imx_check_clk_hws helper function
>   dt-bindings: clock: add imx8qxp clock binding doc
>   clk: imx: add imx8qxp clk driver
> 
>  .../devicetree/bindings/clock/imx8qxp-clk.txt      |  39 ++
>  arch/arm/mach-imx/Kconfig                          |  10 +
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/imx/Kconfig                            |   7 +
>  drivers/clk/imx/Makefile                           |   4 +-
>  drivers/clk/imx/clk-common.h                       |  27 ++
>  drivers/clk/imx/scu/Kconfig                        |   5 +
>  drivers/clk/imx/scu/Makefile                       |  12 +
>  drivers/clk/imx/scu/clk-divider-gpr-scu.c          | 131 +++++++
>  drivers/clk/imx/scu/clk-divider-scu.c              | 129 +++++++
>  drivers/clk/imx/scu/clk-gate-gpr-scu.c             |  84 ++++
>  drivers/clk/imx/scu/clk-gate-scu.c                 | 193 ++++++++++
>  drivers/clk/imx/scu/clk-imx8qxp.c                  | 426 +++++++++++++++++++++
>  drivers/clk/imx/scu/clk-mux-gpr-scu.c              |  90 +++++
>  drivers/clk/imx/scu/clk-mux-scu.c                  |  89 +++++
>  drivers/clk/imx/scu/clk-scu.c                      |  25 ++
>  drivers/clk/imx/scu/clk-scu.h                      |  97 +++++
>  include/dt-bindings/clock/imx8qxp-clock.h          | 362 +++++++++++++++++
>  include/soc/imx/imx8qxp/lpcg.h                     | 186 +++++++++
>  19 files changed, 1916 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-clk.txt
>  create mode 100644 drivers/clk/imx/Kconfig
>  create mode 100644 drivers/clk/imx/clk-common.h
>  create mode 100644 drivers/clk/imx/scu/Kconfig
>  create mode 100644 drivers/clk/imx/scu/Makefile
>  create mode 100644 drivers/clk/imx/scu/clk-divider-gpr-scu.c
>  create mode 100644 drivers/clk/imx/scu/clk-divider-scu.c
>  create mode 100644 drivers/clk/imx/scu/clk-gate-gpr-scu.c
>  create mode 100644 drivers/clk/imx/scu/clk-gate-scu.c
>  create mode 100644 drivers/clk/imx/scu/clk-imx8qxp.c
>  create mode 100644 drivers/clk/imx/scu/clk-mux-gpr-scu.c
>  create mode 100644 drivers/clk/imx/scu/clk-mux-scu.c
>  create mode 100644 drivers/clk/imx/scu/clk-scu.c
>  create mode 100644 drivers/clk/imx/scu/clk-scu.h
>  create mode 100644 include/dt-bindings/clock/imx8qxp-clock.h
>  create mode 100644 include/soc/imx/imx8qxp/lpcg.h
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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180501/ca47fb4d/attachment.sig>
