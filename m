From: marex@denx.de (Marek Vasut)
Date: Tue, 29 May 2012 08:46:53 +0200
Subject: [PATCH 1/2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <4FC359BC.8080606@codethink.co.uk>
References: <1338084656-11961-1-git-send-email-marex@denx.de>
 <4FC359BC.8080606@codethink.co.uk>
Message-ID: <201205290846.53960.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

> On 27/05/12 03:10, Marek Vasut wrote:
> > This patch configures the I2C bus timing registers according
> > to information passed via DT. Currently, 100kHz and 400kHz
> > modes are supported.
> > 
> > Signed-off-by: Marek Vasut<marex@denx.de>
> > Cc: Detlev Zundel<dzu@denx.de>
> > CC: Dong Aisheng<b29396@freescale.com>
> > CC: Fabio Estevam<fabio.estevam@freescale.com>
> > Cc: Linux ARM kernel<linux-arm-kernel@lists.infradead.org>
> > Cc: linux-i2c at vger.kernel.org
> > CC: Sascha Hauer<s.hauer@pengutronix.de>
> > CC: Shawn Guo<shawn.guo@linaro.org>
> > Cc: Stefano Babic<sbabic@denx.de>
> > CC: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
> > Cc: Wolfgang Denk<wd@denx.de>
> > Cc: Wolfram Sang<w.sang@pengutronix.de>
> > ---
> > 
> >   Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    1 +
> >   arch/arm/boot/dts/imx28.dtsi                      |    2 +
> >   drivers/i2c/busses/i2c-mxs.c                      |   64
> >   +++++++++++++++++++++ 3 files changed, 67 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt index
> > 1bfc02d..790b5c6 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > 
> > @@ -4,6 +4,7 @@ Required properties:
> >   - compatible: Should be "fsl,<chip>-i2c"
> >   - reg: Should contain registers location and length
> >   - interrupts: Should contain ERROR and DMA interrupts
> > 
> > +- speed: Speed of the bus in kHz (400 or 100 are supported)
> > 
> >   Examples:
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > index 4634cb8..d927155 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -381,6 +381,7 @@
> > 
> >   				compatible = "fsl,imx28-i2c";
> >   				reg =<0x80058000 2000>;
> >   				interrupts =<111 68>;
> > 
> > +				fsl,speed =<400>;
> > 
> >   				status = "disabled";
> >   			
> >   			};
> > 
> > @@ -390,6 +391,7 @@
> > 
> >   				compatible = "fsl,imx28-i2c";
> >   				reg =<0x8005a000 2000>;
> >   				interrupts =<110 69>;
> > 
> > +				fsl,speed =<400>;
> > 
> >   				status = "disabled";
> >   			
> >   			};
> 
> Is there not a standard speed setting in the i2c binding?

Not that I know of, but if someone hinted one to me, I'd gladly rework the 
patches :)

Best regards,
Marek Vasut
