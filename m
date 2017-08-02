From: sean.wang@mediatek.com (Sean Wang)
Date: Wed, 2 Aug 2017 10:02:41 +0800
Subject: [PATCH v5 03/10] arm: dts: mt7623: add mt6323.dtsi file
In-Reply-To: <1501638477.32089.20.camel@mtksdaap41>
References: <cover.1501486190.git.sean.wang@mediatek.com>
 <f92864cf04cc3ddde20f25d402d8e5d3d915b2a8.1501486190.git.sean.wang@mediatek.com>
 <1501638477.32089.20.camel@mtksdaap41>
Message-ID: <1501639361.17690.21.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-08-02 at 09:47 +0800, Yingjoe Chen wrote:
> On Mon, 2017-07-31 at 15:36 +0800, sean.wang at mediatek.com wrote:
> <...>
> > diff --git a/arch/arm/boot/dts/mt7623-evb.dts b/arch/arm/boot/dts/mt7623-evb.dts
> > index b60b41c..0686ad7 100644
> > --- a/arch/arm/boot/dts/mt7623-evb.dts
> > +++ b/arch/arm/boot/dts/mt7623-evb.dts
> > @@ -14,6 +14,7 @@
> >  
> >  /dts-v1/;
> >  #include "mt7623.dtsi"
> > +#include "mt6323.dtsi"
> >  
> >  / {
> >  	model = "MediaTek MT7623 evaluation board";
> > @@ -23,6 +24,24 @@
> >  		stdout-path = &uart2;
> >  	};
> >  
> > +	cpus {
> > +		cpu0 {
> > +			proc-supply = <&mt6323_vproc_reg>;
> > +		};
> > +
> > +		cpu1 {
> > +			proc-supply = <&mt6323_vproc_reg>;
> > +		};
> > +
> > +		cpu2 {
> > +			proc-supply = <&mt6323_vproc_reg>;
> > +		};
> > +
> > +		cpu3 {
> > +			proc-supply = <&mt6323_vproc_reg>;
> > +		};
> > +	};
> > +
> >  	memory {
> >  		reg = <0 0x80000000 0 0x40000000>;
> >  	};
> > @@ -31,3 +50,13 @@
> >  &uart2 {
> >  	status = "okay";
> >  };
> > +
> > +&mmc0 {
> > +	vmmc-supply = <&mt6323_vemc3v3_reg>;
> > +	vqmmc-supply = <&mt6323_vio18_reg>;
> > +};
> > +
> > +&mmc1 {
> > +	vmmc-supply = <&mt6323_vmch_reg>;
> > +	vqmmc-supply = <&mt6323_vmc_reg>;
> > +};
> 
> Please keep nodes sorted.
> 
> Joe.C
> 
> 

Hi, Joe.C

I will have note for this. Those would be fixed up along with following
patches when mt7623a dts is introduced.

	Sean
