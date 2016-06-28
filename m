From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Jun 2016 15:55:44 -0500
Subject: [PATCH 2/4] input: touchscreen: crtouch_ts: Add driver
In-Reply-To: <1466797486-31558-3-git-send-email-tony.felice@timesys.com>
References: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
 <1466797486-31558-3-git-send-email-tony.felice@timesys.com>
Message-ID: <20160628205544.GH3737@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 03:44:44PM -0400, Anthony Felice wrote:
> Add driver for the Vybrid Tower CRTouch-based touchscreen. This is
> required for the touchscreen on the TWR-LCD-RGB to work on the Vybrid
> Tower platform.
> 
> There is a known issue with this driver: rarely, SW1 on the TWR-LCD-RGB
> module needs to be pressed in order for the touchscreen to begin
> functioning.
> 
> Signed-off-by: Anthony Felice <tony.felice@timesys.com>
> ---
>  .../bindings/input/touchscreen/crtouch_ts.txt      |  14 ++
>  drivers/input/touchscreen/Kconfig                  |  10 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/crtouch_ts.c             | 279 +++++++++++++++++++++
>  4 files changed, 304 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
>  create mode 100644 drivers/input/touchscreen/crtouch_ts.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
> new file mode 100644
> index 0000000..cfb966c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
> @@ -0,0 +1,14 @@
> +* Freescale CRTOUCH based touchscreen
> +
> +Required Properties:
> +- compatible must be fsl,crtouch_ts
> +- reg: I2C address of the touchscreen
> +- irq-gpio: GPIO to use as event IRQ
> +
> +Example:
> +
> +	touch: crtouch at 49 {

touchscreen at 49

> +		compatible = "fsl,crtouch_ts";

Use '-', not '_'.

> +		reg = <0x49>;
> +		irq-gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;

As Dmitry said.
