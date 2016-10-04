From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Tue, 4 Oct 2016 10:02:29 +0530
Subject: [PATCH v1 1/2] ARM: dts: vfxxx: Enable DMA for DSPI on Vybrid
In-Reply-To: <48b237c5d8709a67112465ea147f4c0c@agner.ch>
References: <63fc108e2df00d2297a9b7014955f203bc802f34.1475498805.git.maitysanchayan@gmail.com>
 <48b237c5d8709a67112465ea147f4c0c@agner.ch>
Message-ID: <20161004043228.GA1424@Sanchayan-Arch.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stefan,

On 16-10-03 11:05:59, Stefan Agner wrote:
> On 2016-10-03 05:50, Sanchayan Maity wrote:
> > Enable DMA for DSPI on Vybrid.
> 
> Hm, we have that in 4.4 already, is that meant for 4.1?

Sorry?! I send this out for mainline and the patch series is based
on top of shawn's for-next branch. Did not intend it for our downstream
4.1.

Thanks.

Regards,
Stefan.

> 
> > 
> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > ---
> >  arch/arm/boot/dts/vf-colibri.dtsi | 4 ++++
> >  arch/arm/boot/dts/vfxxx.dtsi      | 6 ++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/vf-colibri.dtsi
> > b/arch/arm/boot/dts/vf-colibri.dtsi
> > index b741709..21bfef9 100644
> > --- a/arch/arm/boot/dts/vf-colibri.dtsi
> > +++ b/arch/arm/boot/dts/vf-colibri.dtsi
> > @@ -108,6 +108,10 @@
> >  	status = "okay";
> >  };
> >  
> > +&edma1 {
> > +	status = "okay";
> > +};
> > +
> >  &esdhc1 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_esdhc1>;
> > diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> > index 2c13ec6..eac4213 100644
> > --- a/arch/arm/boot/dts/vfxxx.dtsi
> > +++ b/arch/arm/boot/dts/vfxxx.dtsi
> > @@ -194,6 +194,9 @@
> >  				clocks = <&clks VF610_CLK_DSPI0>;
> >  				clock-names = "dspi";
> >  				spi-num-chipselects = <6>;
> > +				dmas = <&edma1 1 12>,
> > +					<&edma1 1 13>;
> > +				dma-names = "rx", "tx";
> >  				status = "disabled";
> >  			};
> >  
> > @@ -206,6 +209,9 @@
> >  				clocks = <&clks VF610_CLK_DSPI1>;
> >  				clock-names = "dspi";
> >  				spi-num-chipselects = <4>;
> > +				dmas = <&edma1 1 14>,
> > +					<&edma1 1 15>;
> > +				dma-names = "rx", "tx";
> >  				status = "disabled";
> >  			};
