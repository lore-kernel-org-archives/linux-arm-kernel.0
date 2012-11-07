From: gwenhael.goavec-merou@armadeus.com (gwenhael.goavec)
Date: Wed, 7 Nov 2012 15:20:05 +0100
Subject: [PATCH] ARM: mxs: apf28dev: Add I2C, SPI and spidev support
In-Reply-To: <509A24D4.9000308@free-electrons.com>
References: <1352225793-93208-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <509A24D4.9000308@free-electrons.com>
Message-ID: <20121107152005.549fa8de@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 07 Nov 2012 10:07:32 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Le 06/11/2012 19:16, Gwenhael Goavec-Merou a ?crit :
> > 
> > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> > ---
> >  arch/arm/boot/dts/imx28-apf28dev.dts |   19 +++++++++++++++++++
> >  1 files changed, 19 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
> > index 1643d25..da7013d 100644
> > --- a/arch/arm/boot/dts/imx28-apf28dev.dts
> > +++ b/arch/arm/boot/dts/imx28-apf28dev.dts
> > @@ -27,6 +27,19 @@
> >  				status = "okay";
> >  			};
> >  
> > +			ssp2: ssp at 80014000 {
> > +				compatible = "fsl,imx28-spi";
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&spi2_pins_a>;
> > +				status = "okay";
> > +
> > +				spidev: spidev at 0 {
> > +					compatible = "spidev";
> > +					spi-max-frequency = <40000000>;
> > +					reg = <0>;
> > +				};
> > +			};
> 
> This won't work, since the compatible string is not matching in the
> spidev driver.
>
This patch has been successfully tested on the Shawn Guo's git. Spidev dt
support seems to be not yet available with this git.
>
> You need to add the compatible string of the spi device that you will
> drive with spidev in the spidev driver, and then use this string in your
> dts.
> 
> See
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/129134.html
> and
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/129133.html
> 
The APF28dev docking board contains no spi peripheral by default. The spidev
driver is used to evaluation and fast prototyping of peripherals before creating 
a driver. Consequently it's a bit difficult to add a compatible string... 
What is the solution in this situation? 

Gwenhael Goavec-Merou
Armadeus Systems
