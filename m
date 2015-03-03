From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Mar 2015 10:02:12 +0100
Subject: [PATCH v7 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
In-Reply-To: <1425369498-25541-2-git-send-email-mpa@pengutronix.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <1425369498-25541-2-git-send-email-mpa@pengutronix.de>
Message-ID: <2620642.Qp1W4O8uh6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 March 2015 08:58:11 Markus Pargmann wrote:
> +Example:
> +       tscadc: tscadc at 50030000 {
> +               compatible = "fsl,imx25-tsadc";
> +               reg = <0x50030000 0xc>;
> +               interrupts = <46>;
> +               clocks = <&clks 119>;
> +               clock-names = "ipg";
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               tsc: tcq at 50030400 {
> +                       compatible = "fsl,imx25-tcq";
> +                       reg = <0x50030400 0x60>;
> +                       ...
> +               };
> +
> +               adc: gcq at 50030800 {
> +                       compatible = "fsl,imx25-gcq";
> +                       reg = <0x50030800 0x60>;
> +                       ...
> +               };
> +       };
> 

I wonder if we should just treat this MFD as a single IIO device
that also registers to the input layer.

Are there any other registers in the 0x50030000-0x50031000
range, or could the fsl,imx25-tcq and fsl,imx25-gcq devices
be reused outside of a fsl,imx25-tsadc device?

	Arnd
