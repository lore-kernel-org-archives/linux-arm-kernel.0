From: robh@kernel.org (Rob Herring)
Date: Fri, 12 Aug 2016 13:59:47 -0500
Subject: [PATCH 1/2] input: misc: Add generic input driver to read
 encoded GPIO lines
In-Reply-To: <20160812045229.29241-2-vigneshr@ti.com>
References: <20160812045229.29241-1-vigneshr@ti.com>
 <20160812045229.29241-2-vigneshr@ti.com>
Message-ID: <20160812185947.GA14685@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 10:22:28AM +0530, Vignesh R wrote:
> Add a driver to read group of GPIO lines and provide its status as a
> numerical value as input event to the system. This will help in
> intefacing devices, that can be connected over GPIOs, that provide input
> to the system by driving GPIO lines connected to them like a rotary dial
> or a switch.
> 
> For example, a rotary switch can be connected to four GPIO lines. The
> status of the GPIO lines reflect the actual position of the rotary
> switch dial. For example, if dial points to 9, then the four GPIO lines
> connected to the switch will read HLLH(0b'1001 = 9). This value
> can be reported as an ABS_* event to the input subsystem.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/input/gpio-decoder.txt     |  23 ++++
>  drivers/input/misc/Kconfig                         |  12 ++
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/gpio_decoder.c                  | 128 +++++++++++++++++++++
>  4 files changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-decoder.txt
>  create mode 100644 drivers/input/misc/gpio_decoder.c
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-decoder.txt b/Documentation/devicetree/bindings/input/gpio-decoder.txt
> new file mode 100644
> index 000000000000..efd947f52cb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-decoder.txt
> @@ -0,0 +1,23 @@
> +* GPIO Decoder DT bindings
> +
> +Required Properties:
> +- compatible: should be "gpio-decoder"
> +- gpios: a spec of gpios (atleast two) to be decoded to a number with
> +  first entry representing the MSB.
> +
> +Optional Properties:
> +- gpio-decoder,max-value: Maximum possible value that can be reported by

Just "decoder-max-value".

With that, the binding looks fine to me:

Acked-by: Rob Herring <robh@kernel.org>
