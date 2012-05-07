From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 7 May 2012 15:14:00 +0800
Subject: [alsa-devel] [PATCH RESEND 0/9] Enable pinctrl support for
 mach-mxs
In-Reply-To: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120507071400.GB23607@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 09:16:05AM +0800, Shawn Guo wrote:
> [Resend to have subsystem lists Cc-ed]
> 
> With pinctrl-mxs driver (DT only) applied on pinctrl tree, the mxs
> device tree conversion can start basing on that support.  This series
> adopts pinctrl support for mxs device drivers with a dummy pinctrl
> state provided for non-DT boot, so that the pinctrl call in the device
> drivers will be bypassed for non-DT probe while it starts working for
> DT probe.
> 
> To ease the merge process, I would like to ask Arnd and Olof to pull
> pinctrl tree as a dependency in arm-soc and have this series go through
> arm-soc.
> 
As IMX, basically i'd prefer to add pinctrl states in dts file at the
same time within the patch or using a separate patch to add them before
this series to avoid breaking the exist platforms.

However i noted that for mxs, most drivers here are still not dt capable,
so it may be ok to not add their pinctrl state at this time.

But for the patch "serial: amba-pl011: adopt pinctrl support" since it is
dt capable, so with this patch applied, the mx28 dt boot will fail.
Maybe we should at least add pinctrl states for amba-pl011 first.

> Regards,
> Shawn
> 
> Shawn Guo (9):
>   ARM: mxs: enable pinctrl dummy states
>   serial: amba-pl011: adopt pinctrl support
BTW, will this one break other platforms using this driver?

>   serial: mxs-auart: adopt pinctrl support
>   mmc: mxs-mmc: adopt pinctrl support
>   mtd: nand: gpmi: adopt pinctrl support
>   i2c: mxs: adopt pinctrl support
>   ASoC: mxs-saif: adopt pinctrl support
>   video: mxsfb: adopt pinctrl support
>   ARM: mxs: enable pinctrl support
> 
>  arch/arm/Kconfig                        |    1 +
>  arch/arm/mach-mxs/Kconfig               |    2 ++
>  arch/arm/mach-mxs/include/mach/common.h |    2 ++
>  arch/arm/mach-mxs/mach-apx4devkit.c     |    2 ++
>  arch/arm/mach-mxs/mach-m28evk.c         |    2 ++
>  arch/arm/mach-mxs/mach-mx23evk.c        |    2 ++
>  arch/arm/mach-mxs/mach-mx28evk.c        |    2 ++
>  arch/arm/mach-mxs/mach-stmp378x_devb.c  |    2 ++
>  arch/arm/mach-mxs/mach-tx28.c           |    2 ++
>  arch/arm/mach-mxs/mm.c                  |   11 +++++++++++
>  drivers/i2c/busses/i2c-mxs.c            |    6 ++++++
>  drivers/mmc/host/mxs-mmc.c              |    8 ++++++++
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c  |    9 +++++++++
>  drivers/tty/serial/amba-pl011.c         |    8 ++++++++
>  drivers/tty/serial/mxs-auart.c          |    8 ++++++++
>  drivers/video/mxsfb.c                   |    9 +++++++++
>  sound/soc/mxs/mxs-saif.c                |    8 ++++++++
>  17 files changed, 84 insertions(+), 0 deletions(-)
> 
> -- 
> 1.7.5.4
> 

Regards
Dong Aisheng
