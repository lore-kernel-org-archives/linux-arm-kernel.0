From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Apr 2012 13:26:57 +0800
Subject: [PATCH 0/3] add gpmi-nand dt support for mx6q-arm2 and imx28evk
In-Reply-To: <1334913859-5314-1-git-send-email-b32955@freescale.com>
References: <1334913859-5314-1-git-send-email-b32955@freescale.com>
Message-ID: <20120423052655.GN26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 05:24:16PM +0800, Huang Shijie wrote:
> The mx6q-arm2 and imx28evk have already support the device tree now.
> So i decide to add the gpmi-nand dt support to them.
> 
> The mx23 does not support the device tree now. I will add the gpmi dt support
> when it is ready.
> 
> Test this patch set on both MX6Q-arm2 and mx28evk.
> 
> Huang Shijie (3):
>   ARM: mx6q-arm2: add gpmi-nand dt support
>   ARM: mx28evk: add gpmi-nand dt support
>   mtd: gpmi: add device tree support for mx6q-arm2 and mx28evk

I think the patch "mtd: gpmi: ..." needs to be the first one.  Also,
the support is not board but soc specific, so it really should not
have board name in the patch subject.

Regards,
Shawn

> 
>  .../devicetree/bindings/mtd/gpmi-nand.txt          |   30 +++
>  arch/arm/boot/dts/imx28.dtsi                       |    9 +-
>  arch/arm/boot/dts/imx6q.dtsi                       |   12 +
>  arch/arm/mach-imx/clock-imx6q.c                    |    5 +-
>  arch/arm/mach-mxs/clock-mx28.c                     |    2 +-
>  drivers/mtd/nand/Kconfig                           |    2 +-
>  drivers/mtd/nand/gpmi-nand/bch-regs.h              |   42 +++-
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c              |   18 +-
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |  240 +++++++++-----------
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h             |    6 +-
>  10 files changed, 202 insertions(+), 164 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmi-nand.txt
> 
> 
