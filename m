From: jacopo@jmondi.org (jacopo mondi)
Date: Tue, 15 May 2018 09:21:32 +0200
Subject: [PATCH] ARM: dts: r8a7740: Add CEU1
In-Reply-To: <20180515071006.vmtxzwrppzrgekmf@verge.net.au>
References: <20180507123757.4708-1-horms+renesas@verge.net.au>
 <20180515071006.vmtxzwrppzrgekmf@verge.net.au>
Message-ID: <20180515072132.GP5956@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, May 15, 2018 at 09:10:06AM +0200, Simon Horman wrote:
> On Mon, May 07, 2018 at 02:37:57PM +0200, Simon Horman wrote:
> > Describe CEU1 peripheral for Renesas R-Mobile A1 R8A7740 Soc.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> Would anyone care to review this change?

That would be me, as I've sent patches for CEU0 on R-Mobile A1, sorry
about that.

>
> > ---
> >  arch/arm/boot/dts/r8a7740.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> >  Depends and based on:
> >  "[PATCH v2 2/2] ARM: dts: r8a7740: Add CEU0"
> >
> > diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> > index 508d93440ee8..af4c071c9178 100644
> > --- a/arch/arm/boot/dts/r8a7740.dtsi
> > +++ b/arch/arm/boot/dts/r8a7740.dtsi
> > @@ -77,6 +77,16 @@
> >  		status = "disabled";
> >  	};
> >
> > +	ceu1: ceu at fe914000 {
> > +		reg = <0xfe910000 0x3000>;

The reg property start address does not match the device node unit
address (which is the correct one according to documentation).

Thanks
   j

> > +		compatible = "renesas,r8a7740-ceu";
> > +		interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&mstp1_clks R8A7740_CLK_CEU21>;
> > +		clock-names = "ceu21";
> > +		power-domains = <&pd_a4r>;
> > +		status = "disabled";
> > +	};
> > +
> >  	cmt1: timer at e6138000 {
> >  		compatible = "renesas,cmt-48-r8a7740", "renesas,cmt-48";
> >  		reg = <0xe6138000 0x170>;
> > --
> > 2.11.0
> >
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180515/865bbda0/attachment.sig>
