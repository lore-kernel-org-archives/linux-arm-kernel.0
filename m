From: stillcompiling@gmail.com (stillcompiling at gmail.com)
Date: Fri, 02 Jun 2017 12:39:27 -0700
Subject: [PATCH v11 4/6] ARM: dts: imx6q-evi: support altera-ps-spi
In-Reply-To: <a4d0815c-593f-57a9-41fc-ab636ca9b9e5@suse.de>
References: <20170525172911.11467-1-stillcompiling@gmail.com>
 <20170525172911.11467-5-stillcompiling@gmail.com>
 <a4d0815c-593f-57a9-41fc-ab636ca9b9e5@suse.de>
Message-ID: <6513199.IxvCuS6eYj@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 2, 2017 6:30:12 PM PDT Andreas F?rber wrote:
> Hi,
> 
> Am 25.05.2017 um 19:29 schrieb Joshua Clayton:
> > Add support for Altera V FPGA connected to an spi port
> 
> Did you mean "Altera Cyclone V"?
I meant to shorten it from Altera Cyclone V to Altera FPGA.
Didn't quite make it.  Will fix and resubmit today.
> 
> > to the evi devicetree file
> > 
> > Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> > ---
> > 
> >  arch/arm/boot/dts/imx6q-evi.dts | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6q-evi.dts
> > b/arch/arm/boot/dts/imx6q-evi.dts index 24fe093a66db..a0cbb2d84803 100644
> > --- a/arch/arm/boot/dts/imx6q-evi.dts
> > +++ b/arch/arm/boot/dts/imx6q-evi.dts
> > @@ -82,6 +82,15 @@
> > 
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1cs>;
> >  	status = "okay";
> > 
> > +
> > +	fpga_spi: cyclonespi at 0 {
> 
> "cyclonespi" does not strike me as the best node name.
> 
> I am guessing this is a sub-node of a SPI controller node, so no need to
> repeat "spi", and Cyclone seems more or less implied by "altr,fpga-".
True.
> 
> Note that the example in the bindings doc uses "evi-fpga-spi". Nodes
> don't need to be (shouldn't be?) prefixed with the board. Note that
> bindings examples tend to get copied a lot.
> 
> Any reason not to just use "fpga at 0" in both places for simplicity?
Sure. fpga: fpga at 0 is probably better.
I'll change it in both the dts and the binding doc.
> 
> > +		compatible = "altr,fpga-passive-serial";
> > +		spi-max-frequency = <20000000>;
> > +		reg = <0>;
> > +		pinctrl-0 = <&pinctrl_fpgaspi>;
> > +		nconfig-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> > +		nstat-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
> > +	};
> > 
> >  };
> >  
> >  &ecspi3 {
> 
> [snip]
> 
> Regards,
> Andreas


-- 
~Joshua A Clayton
