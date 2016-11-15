From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 15 Nov 2016 20:22:14 +0200
Subject: [PATCH v2 2/2] arm64: dts: Add ARM PMU node for exynos7
In-Reply-To: <9327f863-7fa3-a967-892c-67158b2471a9@osg.samsung.com>
References: <1478945832-1826-1-git-send-email-alim.akhtar@samsung.com>
 <1478945832-1826-2-git-send-email-alim.akhtar@samsung.com>
 <9327f863-7fa3-a967-892c-67158b2471a9@osg.samsung.com>
Message-ID: <20161115182214.GA8374@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2016 at 11:33:18AM -0300, Javier Martinez Canillas wrote:
> Hello Alim,
> 
> On 11/12/2016 07:17 AM, Alim Akhtar wrote:
> > This patch adds ARM Performance Monitor Unit dt node for exynos7.
> > PMU provides various statistics on the operation of the CPU and
> > memory system at runtime, which are very useful when debugging or
> > profiling code. This enables the same.
> > 
> > Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> > ---
> >  arch/arm64/boot/dts/exynos/exynos7.dtsi |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > Changes since v1:
> > * Added "interrupt-affinity" property as per Robin Murphy review comment.
> > 
> > diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> > index 396ffb9..09e7a05b 100644
> > --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> > +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> > @@ -472,6 +472,16 @@
> >  			status = "disabled";
> >  		};
> >  
> > +		arm-pmu {
> > +			compatible = "arm,cortex-a57-pmu", "arm,armv8-pmuv3";
> > +			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-affinity = <&cpu_atlas0>, <&cpu_atlas1>,
> > +					     <&cpu_atlas2>, <&cpu_atlas3>;
> > +		};
> > +
> 
> I didn't double check if these are the correct IRQs because I don't have
> an Exynos7 user manual, but the change looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Squashed 1/2 with this and applied. Thanks!

Best regards,
Krzysztof
