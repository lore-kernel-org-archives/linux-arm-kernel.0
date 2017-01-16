From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Mon, 16 Jan 2017 18:27:58 +0100
Subject: [PATCH 0/3] watchdog: imx2: handle WMCR only being available on
 i.MX35 and later
In-Reply-To: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
Message-ID: <CAM=E1R62LWEpGFsfgV_DRg8sqK7V1RvdwZGWiXTLgSMUMETRWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 9 January 2017 at 10:50, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> this is my approach to fix the issue reported by Vladimir Zapolskiy.
>

...

> Best regards
> Uwe
>
> Uwe Kleine-K?nig (3):
>   watchdog: imx2: Only i.MX35 and later have a WMCR register
>   dts: teach newer i.MX machines to have the i.MX35 type watchdog
>   watchdog: imx2: add compatibility for new i.MX35 type watchdog
>
>  .../devicetree/bindings/watchdog/fsl-imx-wdt.txt   |  2 +-
>  arch/arm/boot/dts/imx25.dtsi                       |  2 +-
>  arch/arm/boot/dts/imx35.dtsi                       |  2 +-
>  arch/arm/boot/dts/imx50.dtsi                       |  2 +-
>  arch/arm/boot/dts/imx51.dtsi                       |  2 +-
>  arch/arm/boot/dts/imx53.dtsi                       |  2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  2 +-
>  arch/arm/boot/dts/imx6sl.dtsi                      |  4 +-
>  arch/arm/boot/dts/imx6sx.dtsi                      |  6 +-
>  arch/arm/boot/dts/imx6ul.dtsi                      |  4 +-
>  arch/arm/boot/dts/imx7s.dtsi                       |  8 +-
>  arch/arm/boot/dts/vfxxx.dtsi                       |  2 +-
>  arch/arm/mach-imx/devices/devices-common.h         |  1 +
>  arch/arm/mach-imx/devices/platform-imx2-wdt.c      | 13 +--
>  drivers/watchdog/imx2_wdt.c                        | 97 ++++++++++++++++++++--
>  15 files changed, 116 insertions(+), 33 deletions(-)

Tested on i.MX31 PDK board.

Tested-by: Magnus Lilja <lilja.magnus@gmail.com>
