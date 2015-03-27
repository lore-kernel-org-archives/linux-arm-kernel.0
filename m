From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Mar 2015 17:33:19 +0000
Subject: [PATCH v3 4/4] arm64: dts: add interrupt-affinity property to
 pmu node for juno
In-Reply-To: <20150324150528.GE29342@arm.com>
References: <1425642851-27450-1-git-send-email-will.deacon@arm.com>
 <1425642851-27450-5-git-send-email-will.deacon@arm.com>
 <20150324150528.GE29342@arm.com>
Message-ID: <20150327173319.GP1562@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 03:05:28PM +0000, Will Deacon wrote:
> [adding arm-soc folks]
> 
> Hi Arnd, Olof,
> 
> Could you take this Juno .dts patch via arm-soc for 4.1 please? I'll queue
> the perf code to make use of the new binding, but there's not a strict
> dependency (the interrupt-affinity property will be ignored by older
> kernels).

Gentle ping, although I guess most people were tied up with ELC/ACPI this
week.

Happy to resend the patch if necessary.

Will

> On Fri, Mar 06, 2015 at 11:54:11AM +0000, Will Deacon wrote:
> > Make the Juno .dts robust against potential reordering of the CPU nodes
> > by adding an explicit interrupt-affinity property to the PMU node. While
> > we're at it, fix the PMU interrupts numbers too.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/boot/dts/arm/juno.dts | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> > index 133ee59de2d7..5e9110a3353d 100644
> > --- a/arch/arm64/boot/dts/arm/juno.dts
> > +++ b/arch/arm64/boot/dts/arm/juno.dts
> > @@ -120,12 +120,18 @@
> >  
> >  	pmu {
> >  		compatible = "arm,armv8-pmuv3";
> > -		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> > +		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> >  			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> >  			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> > -			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> > -			     <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
> > -			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
> > +			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-affinity = <&A57_0>,
> > +				     <&A57_1>,
> > +				     <&A53_0>,
> > +				     <&A53_1>,
> > +				     <&A53_2>,
> > +				     <&A53_3>;
> >  	};
> >  
> >  	/include/ "juno-clocks.dtsi"
> > -- 
> > 2.1.4
> > 
