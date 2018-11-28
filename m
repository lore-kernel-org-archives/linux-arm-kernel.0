From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Nov 2018 09:02:33 +0000
Subject: [PATCH v3 3/4] iio: adc: add STMPE ADC devicetree bindings
In-Reply-To: <20181123142411.8921-3-dev@pschenker.ch>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181123142411.8921-3-dev@pschenker.ch>
Message-ID: <20181128090233.GQ4272@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Nov 2018, Philippe Schenker wrote:

> From: Stefan Agner <stefan@agner.ch>
> 
> This adds the devicetree bindings for the STMPE ADC.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v3:
>  - Reformatted documentation for touchscreen to use tabs and have a better
>    overview of the settings.
>  - Added note which adc-settings will take precedence.
>  - changed typo in sample-time setting from 144 clocks to 124 clocks, as stated
>    in the datasheet.
> 
> Changes in v2:
>  - Moved the bindings for ADC to the overlying mfd.
>  - Reformatted for better readability
> 
>  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 +++++++
>  .../bindings/input/touchscreen/stmpe.txt      | 60 ++++++++++++-------
>  .../devicetree/bindings/mfd/stmpe.txt         | 28 ++++++---
>  3 files changed, 80 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
[...]

> diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
> index c797c05cd3c2..d4408a417193 100644
> --- a/Documentation/devicetree/bindings/mfd/stmpe.txt
> +++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
> @@ -4,15 +4,29 @@ STMPE is an MFD device which may expose the following inbuilt devices: gpio,
>  keypad, touchscreen, adc, pwm, rotator.
>  
>  Required properties:
> - - compatible                   : "st,stmpe[610|801|811|1600|1601|2401|2403]"
> - - reg                          : I2C/SPI address of the device
> + - compatible			: "st,stmpe[610|801|811|1600|1601|2401|2403]"
> + - reg				: I2C/SPI address of the device

Formatting changes should be completed in a separate patch.

Here they only serve to obscure the real changes you have made.

Please split the formatting changes out and re-submit.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
