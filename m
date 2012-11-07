From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Nov 2012 18:54:32 +0100
Subject: Testing i2c in 3.6.0-next-20121012 for i.mx233
In-Reply-To: <1350096488.12723.YahooMailNeo@web162606.mail.bf1.yahoo.com>
References: <1350096488.12723.YahooMailNeo@web162606.mail.bf1.yahoo.com>
Message-ID: <CAOMZO5DLPqsx6tFWiPsVA=32LJ85XktSN2ar+FwOKgsArb_oqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Sat, Oct 13, 2012 at 4:48 AM, Tim michals <tcmichals@yahoo.com> wrote:
> Using the 3.6.0-next-20121012  to test i2c DMA support on a
> imx233-Olinuxino-micro board.  When using the i2cdetect -r 0 to scan a
> devices on the i2c bus,  the following message is displayed on the console:
>
> -- [  129.130000] mxs-i2c 80058000.i2c: Failed to get PIO reg. write
> descriptor.
>
> imx23.dtsi support for i2c:
> i2c0_pins_a: i2c0 at 0 {
> reg = <0>;
> fsl,pinmux-ids = <
> 0x1171 /* MX23_PAD_LCD_ENABLE__LCD_ENABLE */
> 0x1181 /* MX23_PAD_LCD_HSYNC__LCD_HSYNC */
>>;
> fsl,drive-strength = <1>;
> fsl,voltage = <1>;
> fsl,pull-up = <1>;
> };
> ...
> i2c at 80058000 {
> #address-cells = <1>;
>                                #size-cells = <0>;
> compatible = "fsl,imx28-i2c";

This shoulbe be imx23-i2c instead.

Regards,

Fabio Estevam
