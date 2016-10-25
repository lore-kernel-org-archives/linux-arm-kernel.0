From: hongtao.jia@nxp.com (Troy Jia)
Date: Tue, 25 Oct 2016 02:29:46 +0000
Subject: [PATCH V2 1/5] powerpc/mpc85xx: Update TMU device tree node for
 T1040/T1042
In-Reply-To: <20161024083654.GB30578@tiger>
References: <1475995626-14049-1-git-send-email-hongtao.jia@nxp.com>
 <20161024083654.GB30578@tiger>
Message-ID: <AM4PR0401MB18431A1DD9E2061FC71414D3EBA80@AM4PR0401MB1843.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Monday, October 24, 2016 4:37 PM
> To: Troy Jia <hongtao.jia@nxp.com>
> Cc: rui.zhang at intel.com; edubezval at gmail.com; robh+dt at kernel.org; Scott Wood
> <scott.wood@nxp.com>; devicetree at vger.kernel.org; linuxppc-
> dev at lists.ozlabs.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH V2 1/5] powerpc/mpc85xx: Update TMU device tree node for
> T1040/T1042
> 
> On Sun, Oct 09, 2016 at 02:47:02PM +0800, Jia Hongtao wrote:
> > From: Hongtao Jia <hongtao.jia@nxp.com>
> >
> > SoC compatible string and endianness property are added according to
> > the new bindings.
> 
> The commit log doesn't seem to match the actual changes.  Same for patch 2/5.

Right. I just revise the log and sent a new version. Please help to review.
Thanks.

-Hongtao.

> 
> >
> > Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> > ---
> > Changes for V2:
> > * Rebase on latest linux-next tree (next-20161006).
> >
> >  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > index 44e399b..145c7f4 100644
> > --- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > @@ -526,7 +526,7 @@
> >
> >  				       0x00030000 0x00000012
> >  				       0x00030001 0x0000001d>;
> > -		#thermal-sensor-cells = <0>;
> > +		#thermal-sensor-cells = <1>;
> >  	};
> >
> >  	thermal-zones {
> > @@ -534,7 +534,7 @@
> >  			polling-delay-passive = <1000>;
> >  			polling-delay = <5000>;
> >
> > -			thermal-sensors = <&tmu>;
> > +			thermal-sensors = <&tmu 2>;
> >
> >  			trips {
> >  				cpu_alert: cpu-alert {
> > --
> > 2.1.0.27.g96db324
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
