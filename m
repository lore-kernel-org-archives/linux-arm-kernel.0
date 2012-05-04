From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 4 May 2012 11:12:05 +0200
Subject: [PATCH] ARM: imx: rename uart and fec device tree nodes
In-Reply-To: <1333350084-5993-1-git-send-email-shawn.guo@linaro.org>
References: <1333350084-5993-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4FA39D65.3020007@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 02.04.2012 09:01, Shawn Guo wrote:
> It has been pointed out by device tree maintainer for several times
> that the generic names 'serial' and 'ethernet' should be used for
> those devices per ePAPR.  Renames imx uart and fec device tree nodes
> to stop them being bad examples.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/fsl-fec.txt  |    2 +-
>  .../bindings/tty/serial/fsl-imx-uart.txt           |    2 +-
>  arch/arm/boot/dts/imx27-phytec-phycore.dts         |    8 ++++----
>  arch/arm/boot/dts/imx27.dtsi                       |   14 +++++++-------
>  arch/arm/boot/dts/imx51-babbage.dts                |    8 ++++----
>  arch/arm/boot/dts/imx51.dtsi                       |    8 ++++----
>  arch/arm/boot/dts/imx53-ard.dts                    |    2 +-
>  arch/arm/boot/dts/imx53-evk.dts                    |    4 ++--
>  arch/arm/boot/dts/imx53-qsb.dts                    |    4 ++--
>  arch/arm/boot/dts/imx53-smd.dts                    |    8 ++++----
>  arch/arm/boot/dts/imx53.dtsi                       |   12 ++++++------
>  arch/arm/boot/dts/imx6q-arm2.dts                   |    4 ++--
>  arch/arm/boot/dts/imx6q-sabrelite.dts              |    4 ++--
>  arch/arm/boot/dts/imx6q.dtsi                       |   12 ++++++------
>  arch/arm/mach-imx/clock-imx6q.c                    |   12 ++++++------
>  15 files changed, 52 insertions(+), 52 deletions(-)
...
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 4663a4e..a93c593 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
...
> @@ -43,7 +43,7 @@
>                                 status = "okay";
>                         };
> 
> -                       uart2: uart at 021e8000 {
> +                       uart2: serial at 021e8000 {
>                                 status = "okay";
>                         };
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 68f2e42..56c5304 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
...
> @@ -627,28 +627,28 @@
>                                 interrupts = <0 18 0x04>;
>                         };
> 
> -                       uart2: uart at 021e8000 {
> +                       uart2: serial at 021e8000 {
>                                 compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
>                                 reg = <0x021e8000 0x4000>;
>                                 interrupts = <0 27 0x04>;
>                                 status = "disabled";
>                         };

Having this patch on a 3.4-rc5 based test branch and booting it on the 
SabreLite I get (with earlyprintk enabled):

Serial: IMX driver
imx-uart: probe of 21e8000.serial failed with error -2

resulting in no console output. Reverting this patch I get

Serial: IMX driver
21e8000.uart: ttymxc1 at MMIO 0x21e8000 (irq = 59) is a IMX

and console works fine again.

Have I missed anything?

Best regards

Dirk
