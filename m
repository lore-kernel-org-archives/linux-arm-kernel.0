From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 2 Jul 2016 17:12:55 +0800
Subject: [PATCH 1/2] iio: sun4i-lradc: Add binding documentation
In-Reply-To: <1467406855-9677-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1467406855-9677-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CAGb2v66PzgVqVGxs4FSQkkX=2hX42UmftahOgJmepv4wA-mwnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jul 2, 2016 at 5:00 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Document the bindings for the Allwinner LRADC.

We already have Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
and I'm pretty sure Hans (CC-ed) argued that this is not a generic ADC
block.

Any plans to reconcile the different bindings?

Thanks
ChenYu

>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
>
>  .../devicetree/bindings/iio/adc/sun4i-lradc.txt       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt b/Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt
> new file mode 100644
> index 000000000000..c75a6067b8a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt
> @@ -0,0 +1,19 @@
> +Allwinner sun4i Low Resolution ADC
> +----------------------------------
> +
> +Required properties:
> + - compatible: "allwinner,sun4i-a10-lradc"
> + - reg: mmio address range of the chip
> + - interrupts: interrupt to which the chip is connected
> + - vref-supply: powersupply for the lradc reference voltage
> + - #io-channel-cells = <1>; As ADC has multiple outputs
> +
> +Example:
> +
> +       lradc: lradc at 01c22800 {
> +               compatible = "allwinner,sun4i-a10-lradc";
> +               reg = <0x01c22800 0x100>;
> +               interrupts = <31>;
> +               vref-supply = <&reg_vcc3v0>;
> +               #io-channel-cells = <1>;
> +       };
> --
> 2.8.1
>
