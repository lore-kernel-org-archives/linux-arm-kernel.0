From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 23 Jul 2013 11:00:32 +0900
Subject: [PATCH 2/3] drm/exynos: add dt-binding documentation for rotator
In-Reply-To: <1654536.B4gG8HrWlH@flatron>
References: <1374475767-30085-1-git-send-email-chanho61.park@samsung.com>
 <027201ce86df$cd883d90$6898b8b0$%dae@samsung.com>
 <51ED3AF6.3090004@samsung.com> <1654536.B4gG8HrWlH@flatron>
Message-ID: <008001ce8748$6a0a2d50$3e1e87f0$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-samsung-soc-owner at vger.kernel.org [mailto:linux-samsung-soc-
> owner at vger.kernel.org] On Behalf Of Tomasz Figa
> Sent: Tuesday, July 23, 2013 4:29 AM
> To: Sylwester Nawrocki
> Cc: Inki Dae; 'Chanho Park'; 'Lucas Stach'; 'Mark Rutland'; linux-samsung-
> soc at vger.kernel.org; devicetree-discuss at lists.ozlabs.org;
> sw0312.kim at samsung.com; dri-devel at lists.freedesktop.org;
> kyungmin.park at samsung.com; kgene.kim at samsung.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 2/3] drm/exynos: add dt-binding documentation for
> rotator
> 
> On Monday 22 of July 2013 16:00:22 Sylwester Nawrocki wrote:
> > On 07/22/2013 03:31 PM, Inki Dae wrote:
> > >> ---Original Message-----
> > >>
> > >> > From: linux-samsung-soc-owner at vger.kernel.org
> > >> > [mailto:linux-samsung-soc- owner at vger.kernel.org] On Behalf Of
> > >> > Lucas Stach
> > >> > Sent: Monday, July 22, 2013 9:47 PM
> > >> > To: Inki Dae
> > >> > Cc: 'Mark Rutland'; 'Chanho Park';
> > >> > linux-samsung-soc at vger.kernel.org;
> > >> > devicetree-discuss at lists.ozlabs.org; sw0312.kim at samsung.com; dri-
> > >> > devel at lists.freedesktop.org; kyungmin.park at samsung.com;
> > >> > kgene.kim at samsung.com; linux-arm-kernel at lists.infradead.org
> > >> > Subject: Re: [PATCH 2/3] drm/exynos: add dt-binding documentation
> > >> > for
> > >> > rotator
> > >> >
> > >> > Am Montag, den 22.07.2013, 21:37 +0900 schrieb Inki Dae:
> > >>>> > > > -----Original Message-----
> > >>>> > > > From: Mark Rutland [mailto:mark.rutland at arm.com]
> > >>>> > > > Sent: Monday, July 22, 2013 5:48 PM
> > >>>> > > > To: Chanho Park
> > >>>> > > > Cc: inki.dae at samsung.com; kgene.kim at samsung.com;
> > >>>> > > > linux-samsung-
> > >>>> > > > soc at vger.kernel.org; jy0922.shim at samsung.com; devicetree-
> > >>>> > > > discuss at lists.ozlabs.org; sw0312.kim at samsung.com; dri-
> > >>>> > > > devel at lists.freedesktop.org; kyungmin.park at samsung.com;
> > >>>> > > > linux-arm-
> > >>>> > > > kernel at lists.infradead.org
> > >>>> > > > Subject: Re: [PATCH 2/3] drm/exynos: add dt-binding
> > >>>> > > > documentation for
> > >>>> > > > rotator
> > >>>> > > >
> > >>>> > > > On Mon, Jul 22, 2013 at 07:49:26AM +0100, Chanho Park wrote:
> > >>>>> > > > > This patch adds a dt-binding document for exynos rotator.
> > >>>>> > > > > It
> > >> >
> > >> > describes
> > >> >
> > >>>> > > > which
> > >>>> > > >
> > >>>>> > > > > nodes should be defined to use the rotator.
> > >>>>> > > > >
> > >>>>> > > > > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > >>>>> > > > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > >>>>> > > > > ---
> > >>>>> > > > >
> > >>>>> > > > >  .../bindings/drm/exynos/samsung-rotator.txt        |   35
> > >>>> > > >
> > >>>> > > > ++++++++++++++++++++
> > >>>> > > >
> > >>>>> > > > >  1 file changed, 35 insertions(+)
> > >>>>> > > > >  create mode 100644
> > >>>> > > >
> > >>>> > > > Documentation/devicetree/bindings/drm/exynos/samsung-rotator.
> > >>>> > > > txt
> > >>>> > > >
> > >>>>> > > > > diff --git
> > >>>>> > > > > a/Documentation/devicetree/bindings/drm/exynos/samsung-
> > >>>> > > >
> > >>>> > > > rotator.txt
> > >>>> > > > b/Documentation/devicetree/bindings/drm/exynos/samsung-
> > >>>> > > > rotator.txt
> > >>>> > > >
> > >>>>> > > > > new file mode 100644
> > >>>>> > > > > index 0000000..6b1d704
> > >>>>> > > > > --- /dev/null
> > >>>>> > > > > +++
> > >>>>> > > > > b/Documentation/devicetree/bindings/drm/exynos/samsung-
> > >> >
> > >> > rotator.txt
> > >> >
> > >>>>> > > > > @@ -0,0 +1,35 @@
> > >>>>> > > > > +* Samsung Image Rotator
> > >>>>> > > > > +
> > >>>>> > > > > +Required properties:
> > >>>>> > > > > +  - compatible : value should be the
> > >>>>> > > > > "samsung,exynos4210".
> > >>> > >
> > >>> > > Please, add more compatible strings for other SoC.
> > >>> > >
> > >>>>> > > > > +  - reg : Physical base address of the IP registers and
> > >>>>> > > > > length of
> > >>>> > > >
> > >>>> > > > memory
> > >>>> > > >
> > >>>>> > > > > +	  mapped region.
> > >>>>> > > > > +  - interrupts : interrupt number to the CPU.
> > >>>>> > > > > +  - clocks : clock number of exynos4 rotator clock.
> > >>>>> > > > > +  - clocks : clock name of rotator
> > >>>> > > >
> > >>>> > > > clock-names?
> > >>>> > > >
> > >>>>> > > > > +  - status : "okay" or "disabled"
> > >>>>> > > > > +  - limit table for image formats :
> > >>>>> > > > > min_w/min_h/max_w/max_h for
> > >> >
> > >> > min/max
> > >> >
> > >>>> > > > of image
> > >>>> > > >
> > >>>> > > > Limit table? This doesn't seem to be a well-defined binding,
> > >>>> > > > and it
> > >>>> > > > seems like a relatively generic thing to describe.
> > >>>> > > >
> > >>>>> > > > > +
> > >>>>> > > > > +Example:
> > >>>>> > > > > +	rotator: rotator at 12810000 {
> > >>>>> > > > > +		compatible = "samsung,exynos4210-rotator";
> > >>>>> > > > > +		reg = <0x12810000 0x1000>;
> > >>>>> > > > > +		interrupts = <0 83 0>;
> > >>>>> > > > > +		clocks = <&clock 278>;
> > >>>>> > > > > +		clock-names = "rotator";
> > >>>>> > > > > +		status = "disabled";
> > >>>>> > > > > +		ycbcr420_2p {
> > >>>> > > >
> > >>>> > > > Which names are allowed for these subnodes?
> > >>>> > > >
> > >>>>> > > > > +			min_w = <32>;
> > >>>>> > > > > +			min_h = <32>;
> > >>>>> > > > > +			max_w = <32768>;
> > >>>>> > > > > +			max_h = <32768>;
> > >>>>> > > > > +			align = <3>;
> > >>>> > > >
> > >>>> > > > min-width, min-height, max-width, max-height? What units are
> > >>>> > > > they in?
> > >>>> > > >
> > >>>> > > > What does alignment specify exactly?
> > >>>> > > >
> > >>>> > > > Are these a configurable part of the rotator hardware, or are
> > >>>> > > > these
> > >>>> > > > values always the same?
> > >>> > >
> > >>> > > Right, that seems like configurable part. At least, min_w/h and
> > >>> > > max_w/h
> > >> >
> > >> > can
> > >> >
> > >>> > > be different values according to SoC and pixel formats so they
> > >>> > > should be described enough in this dt-binding document file.
> > >> >
> > >> > Is there really this much configurability? Could each of those
> > >> > values be a different on different SoCs
> > >
> > > Not much but Yes. Rotator devices of Exynos SoC support various pixel
> > > formats; RGB888, RGB565, YUV422, YUV420-2Plane, and YUV420-3Plane,
> > > and each of these pixel formats could be different limitation to
> > > minimum and maximum sizes. For example, the below shows the
> > > limitation to Rotator device of Exynos4412 SoC according to pixel
> > > formats,>
> > >          Image format          Minimum size          Maximum size
> > >
> > >           RGB888                    8x8                     8kx8k
> > >           RGB565                    16x16                  16kx16k
> > >           YUV422                    16x16                  16kx16k
> > >           YUV420 2-Plane         32x32                  32kx32k(in
> > >           case of Y components) YUV420 3-Plane         64x32
> > >                   32kx32k(in case of Y components)>
> > > And, I guess those limitations are slightly different according to
> > > Exynos SoC versions as long as I know.
> > >
> > > Thanks,
> > > Inki Dae
> > >
> > >> > , or could you just extract those values
> > >> > from the SoC/rotator hardware version and thus the DT compatible
> > >> > string?
> > My gut feeling is that those constraints could be well defined
> > in the driver as static data and selected by the compatible property.
> > Defining this in Device Tree may easily get out of control, when the
> > limits become dependant on more parameters.
> >
> > Whether devices should be described in much detail in DT rather than
> > using multiple compatible strings had been discussed multiple times,
> > for instance please see thread [1].
> 
> +1
> 
> The binding should not describe hardware functionality and how it works,
> but rather what hardware it is, unless it is really necessary.

Good comments. Agree.

Thanks,
Inki Dae

> In this
> case this information can be placed in per-compatible static driver data,
> so there is no such need.
> 
> Best regards,
> Tomasz
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-
> soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
