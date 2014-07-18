From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Jul 2014 10:35:52 +0100
Subject: [PATCH v2 6/7] ARM: dts: rockchip: add core rk3288 dtsi
In-Reply-To: <14646641.DlFrJR068n@diego>
References: <4868343.UFgjaXesOn@diego>
 <14646641.DlFrJR068n@diego>
Message-ID: <20140718093551.GE25180@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu at 500 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a12";
> +                       reg = <0x500>;
> +               };
> +               cpu at 501 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a12";
> +                       reg = <0x501>;
> +               };
> +               cpu at 502 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a12";
> +                       reg = <0x502>;
> +               };
> +               cpu at 503 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a12";
> +                       reg = <0x503>;

I take it that we can only use one of these for the moment? I didn't see
the addition of any SMP code.

Or did I miss that?

[...]

> +       timer {
> +               compatible = "arm,armv7-timer";
> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +               clock-frequency = <24000000>;
> +       };

Please say you don't need this clock-frequency property.

It's a work-around at best, and you won't be able to use Hyp properly.
I'd really like to discourage use of this property, especially as people
seem to set it regardless of whether the hardware's correct...

What's the state of CNTFREQ and CNTVOFF, and is there any chance that
these are sane?

Cheers,
Mark.
