From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 23 Jul 2013 10:35:45 +0900
Subject: [PATCH 2/3] drm/exynos: add dt-binding documentation for rotator
In-Reply-To: <00f701ce8742$fa8c67e0$efa537a0$@samsusng.com>
References: <1374475767-30085-1-git-send-email-chanho61.park@samsung.com>
 <1374475767-30085-3-git-send-email-chanho61.park@samsung.com>
 <20130722084817.GA18731@e106331-lin.cambridge.arm.com>
 <00f701ce8742$fa8c67e0$efa537a0$@samsusng.com>
Message-ID: <007f01ce8744$f3d1c560$db755020$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Chanho Park [mailto:chanho61.park at samsusng.com]
> Sent: Tuesday, July 23, 2013 10:22 AM
> To: 'Mark Rutland'; 'Chanho Park'
> Cc: inki.dae at samsung.com; kgene.kim at samsung.com; linux-samsung-
> soc at vger.kernel.org; jy0922.shim at samsung.com; sw0312.kim at samsung.com; dri-
> devel at lists.freedesktop.org; kyungmin.park at samsung.com; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: [PATCH 2/3] drm/exynos: add dt-binding documentation for
> rotator
> 
> Hi Mark,
> Thank you for your review.
> 
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland at arm.com]
> > Sent: Monday, July 22, 2013 5:48 PM
> > To: Chanho Park
> > Cc: inki.dae at samsung.com; kgene.kim at samsung.com; linux-samsung-
> > soc at vger.kernel.org; jy0922.shim at samsung.com; devicetree-
> > discuss at lists.ozlabs.org; sw0312.kim at samsung.com; dri-
> > devel at lists.freedesktop.org; kyungmin.park at samsung.com; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH 2/3] drm/exynos: add dt-binding documentation for
> > rotator
> >
> > On Mon, Jul 22, 2013 at 07:49:26AM +0100, Chanho Park wrote:
> > > This patch adds a dt-binding document for exynos rotator. It describes
> > > which nodes should be defined to use the rotator.
> > >
> > > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > ---
> > >  .../bindings/drm/exynos/samsung-rotator.txt        |   35
> > ++++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/drm/exynos/samsung-rotator.txt
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/drm/exynos/samsung-rotator.txt
> > > b/Documentation/devicetree/bindings/drm/exynos/samsung-rotator.txt
> > > new file mode 100644
> > > index 0000000..6b1d704
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/drm/exynos/samsung-rotator.txt
> > > @@ -0,0 +1,35 @@
> > > +* Samsung Image Rotator
> > > +
> > > +Required properties:
> > > +  - compatible : value should be the "samsung,exynos4210".
> > > +  - reg : Physical base address of the IP registers and length of
> > memory
> > > +	  mapped region.
> > > +  - interrupts : interrupt number to the CPU.
> > > +  - clocks : clock number of exynos4 rotator clock.
> > > +  - clocks : clock name of rotator
> >
> > clock-names?
> 
> Yes. It seems to have ??a mistake during copy and paste.
> I'll modify it next patch.
> 
> >
> > > +  - status : "okay" or "disabled"
> > > +  - limit table for image formats : min_w/min_h/max_w/max_h for
> > > + min/max of image
> >
> > Limit table? This doesn't seem to be a well-defined binding, and it
> > seems like a relatively generic thing to describe.
> >
> > > +
> > > +Example:
> > > +	rotator: rotator at 12810000 {
> > > +		compatible = "samsung,exynos4210-rotator";
> > > +		reg = <0x12810000 0x1000>;
> > > +		interrupts = <0 83 0>;
> > > +		clocks = <&clock 278>;
> > > +		clock-names = "rotator";
> > > +		status = "disabled";
> > > +		ycbcr420_2p {
> >
> > Which names are allowed for these subnodes?
> >
> > > +			min_w = <32>;
> > > +			min_h = <32>;
> > > +			max_w = <32768>;
> > > +			max_h = <32768>;
> > > +			align = <3>;
> >
> > min-width, min-height, max-width, max-height? What units are they in?
> >
> > What does alignment specify exactly?
> >
> > Are these a configurable part of the rotator hardware, or are these
> > values always the same? If thery're always the same, there's no need to
> > describe in in the devicetree.
> 
> I've checked the rotator limitation for all of exynos4 chipsets and
> exynos5250.
> As a result, these have same value.

Not true. See the Exynos4210 user manual again. At least, the manual says maximum size is 64k x 64k in case of Y components.

> I think it seems to be better leave on static value.
> I'll prepare next patches including your suggestion.
> 

So, you should consider such a little bit difference.

> Thanks
> 
> Best Regards,
> Chanho Park
> 
> >
> > Thanks,
> > Mark.
> >
> > > +		};
> > > +		rgb888 {
> > > +			min_w = <8>;
> > > +			min_h = <8>;
> > > +			max_w = <8192>;
> > > +			max_h = <8192>;
> > > +			align = <2>;
> > > +		};
> > > +	};
> > > --
> > > 1.7.9.5
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > >
