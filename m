From: jason77.wang@gmail.com (Hui Wang)
Date: Thu, 28 Jun 2012 14:07:13 +0800
Subject: [PATCH] bindings: update imx and mxs #gpio-cells
In-Reply-To: <1340853337-4406-1-git-send-email-shawn.guo@linaro.org>
References: <1340853337-4406-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4FEBF491.8040003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> The of_get_named_gpio_flags can retrieve the second cell of
> gpio-specifier as the "flags".  The imx and mxs gpio driver do not
> have their own .xlate callback, which means of_gpio_simple_xlate is
> used and it's a 1:1 mapping between gpio controller flags and Linux
> "enum of_gpio_flags".
>
> Update imx and mxs bindings document to make it clear.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../devicetree/bindings/gpio/fsl-imx-gpio.txt      |    5 +++--
>  .../devicetree/bindings/gpio/gpio-mxs.txt          |    5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
> index 4363ae4..5f360e7 100644
> --- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
> @@ -8,8 +8,9 @@ Required properties:
>    by low 16 pins and the second one is for high 16 pins.
>  - gpio-controller : Marks the device node as a gpio controller.
>  - #gpio-cells : Should be two.  The first cell is the pin number and
> -  the second cell is used to specify optional parameters (currently
> -  unused).
> +  the second cell is used to specify the gpio polarity:
> +      0 = active high
> +      1 = active low
>   
Agree with this design, looks good to me.

Regards,
Hui.
>  
>  Example:
>  
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mxs.txt b/Documentation/devicetree/bindings/gpio/gpio-mxs.txt
> index 0c35673..1e677a4 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mxs.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mxs.txt
> @@ -13,8 +13,9 @@ Required properties for GPIO node:
>  - interrupts : Should be the port interrupt shared by all 32 pins.
>  - gpio-controller : Marks the device node as a gpio controller.
>  - #gpio-cells : Should be two.  The first cell is the pin number and
> -  the second cell is used to specify optional parameters (currently
> -  unused).
> +  the second cell is used to specify the gpio polarity:
> +      0 = active high
> +      1 = active low
>  - interrupt-controller: Marks the device node as an interrupt controller.
>  - #interrupt-cells : Should be 2.  The first cell is the GPIO number.
>    The second cell bits[3:0] is used to specify trigger type and level flags:
>   
