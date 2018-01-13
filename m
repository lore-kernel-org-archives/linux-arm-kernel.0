From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 13 Jan 2018 11:06:02 +0100 (CET)
Subject: [PATCH v2 2/4] dt-bindings: gpio: add raspberry pi GPIO
 expander binding
In-Reply-To: <a93ba9ec4d3d3ff6d1e2a79f4f813a2f86c4086b.1515698418.git.baruch@tkos.co.il>
References: <cover.1515698418.git.baruch@tkos.co.il>
 <a93ba9ec4d3d3ff6d1e2a79f4f813a2f86c4086b.1515698418.git.baruch@tkos.co.il>
Message-ID: <553468547.42989.1515837962934@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

> Baruch Siach <baruch@tkos.co.il> hat am 11. Januar 2018 um 20:44 geschrieben:
> 
> 
> The Raspberry Pi 3 GPIO expander is controlled by the VC4 firmware over
> I2C. The firmware mailbox interface allows the ARM core to control the
> GPIO lines.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2:
>   * Rename compatible string to raspberrypi,firmware-gpio
> ---
>  .../bindings/gpio/raspberrypi,firmware-gpio.txt    | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt b/Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt
> new file mode 100644
> index 000000000000..8faf269cf541
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt
> @@ -0,0 +1,24 @@
> +Raspberry Pi GPIO expander
> +
> +The Raspberry Pi 3 GPIO expander is controlled by the VC4 firmware. The
> +firmware exposes a mailbox interface that allows the ARM core to control the
> +GPIO lines on the expander.
> +
> +Required properties:
> +
> +- compatible : Should be "raspberrypi,firmware-gpio"
> +- gpio-controller : Marks the device node as a gpio controller
> +- #gpio-cells : Should be two.  The first cell is the pin number, and
> +  the second cell is used to specify the gpio polarity:
> +  0 = active high
> +  1 = active low
> +- firmware : Reference to the RPi firmware device node
> +
> +Example:
> +
> +expgpio: expgpio {

just a nit, please change this to

expgpio: gpio-expander {

just like in patch #4


Thanks Stefan
