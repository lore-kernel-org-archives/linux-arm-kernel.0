From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 18 Oct 2011 12:18:46 +0200
Subject: [PATCH v6 0/2] Add device tree support for i.mx51/53 boards
In-Reply-To: <1318812137-13991-1-git-send-email-shawn.guo@linaro.org>
References: <1318812137-13991-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111018101846.GL18141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Mon, Oct 17, 2011 at 08:42:15AM +0800, Shawn Guo wrote:
> Changes since v5:
>  * Retrieve fixed clock frequency from device tree
> 
> Changes since v4:
>  * Rebase onto imx-features branch
>  * Have devices in soc dtsi as "disabled" and explicitly enable the
>    ones in board dts as "okay"
>  * Utilize of_irq_init() infrastructure added by Rob Herring recently
> 
> Shawn Guo (2):
>       arm/mx5: add device tree support for imx53 boards
>       arm/mx5: add device tree support for imx51 babbage

You sent this patches to Arnd but without saying what he should do with
them. Shall I queue them up or does Arnd handle them? Same with the
include cleanup series.

Sascha

> 
>  Documentation/devicetree/bindings/arm/fsl.txt |   19 ++
>  arch/arm/boot/dts/imx51-babbage.dts           |  135 +++++++++++
>  arch/arm/boot/dts/imx51.dtsi                  |  246 ++++++++++++++++++++
>  arch/arm/boot/dts/imx53-ard.dts               |  113 +++++++++
>  arch/arm/boot/dts/imx53-evk.dts               |  120 ++++++++++
>  arch/arm/boot/dts/imx53-qsb.dts               |  125 ++++++++++
>  arch/arm/boot/dts/imx53-smd.dts               |  169 ++++++++++++++
>  arch/arm/boot/dts/imx53.dtsi                  |  301 +++++++++++++++++++++++++
>  arch/arm/mach-mx5/Kconfig                     |   21 ++
>  arch/arm/mach-mx5/Makefile                    |    3 +
>  arch/arm/mach-mx5/board-mx51_babbage.c        |    9 +-
>  arch/arm/mach-mx5/board-mx53_ard.c            |   12 +-
>  arch/arm/mach-mx5/board-mx53_evk.c            |    9 +-
>  arch/arm/mach-mx5/board-mx53_loco.c           |    9 +-
>  arch/arm/mach-mx5/board-mx53_smd.c            |    9 +-
>  arch/arm/mach-mx5/clock-mx51-mx53.c           |   39 ++++
>  arch/arm/mach-mx5/imx51-dt.c                  |  116 ++++++++++
>  arch/arm/mach-mx5/imx53-dt.c                  |  126 +++++++++++
>  arch/arm/plat-mxc/include/mach/common.h       |    8 +
>  19 files changed, 1577 insertions(+), 12 deletions(-)
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
