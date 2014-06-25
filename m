From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 Jun 2014 15:00:53 +0800
Subject: [PATCH 1/2] ARM: i.MX27: Introduce DT include for clock provider
In-Reply-To: <1403426090-29806-1-git-send-email-shc_work@mail.ru>
References: <1403426090-29806-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140625070052.GC2224@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 22, 2014 at 12:34:49PM +0400, Alexander Shiyan wrote:
> Use clock defines in order to make devicetrees more human readable.
> Additional changes included in this patch (imx27.dtsi):
> - Fix IPG clock for UART6.
> - Use EMI_AHB_GATE clock for WEIM.
> - Added GPIO_IPG_GATE clock for GPIO nodes. Currently this clock is
>   not used by the driver, but it can be added in the future.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../devicetree/bindings/clock/imx27-clock.txt      | 127 +-------
>  arch/arm/boot/dts/imx27-pdk.dts                    |   2 +-
>  arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   2 +-
>  arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   2 +-
>  arch/arm/boot/dts/imx27.dtsi                       | 115 ++++---
>  arch/arm/mach-imx/clk-imx27.c                      | 347 ++++++++++-----------
>  include/dt-bindings/clock/imx27-clock.h            | 107 +++++++
>  7 files changed, 362 insertions(+), 340 deletions(-)
>  create mode 100644 include/dt-bindings/clock/imx27-clock.h

Please split all the dts files into a second patch.

Shawn
