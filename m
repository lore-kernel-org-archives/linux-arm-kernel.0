From: chanho61.park@samsung.com (Chanho Park)
Date: Fri, 25 Apr 2014 11:03:54 +0900
Subject: [PATCH] ARM: dts: exynos4: clean up arm-pmu node
In-Reply-To: <53594416.4070601@samsung.com>
References: <1397480584-16195-1-git-send-email-chanho61.park@samsung.com>
 <53594416.4070601@samsung.com>
Message-ID: <00e201cf602a$9c8b6df0$d5a249d0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Tomasz Figa
> Sent: Friday, April 25, 2014 2:04 AM
> To: Chanho Park; kgene.kim at samsung.com; linux-samsung-
> soc at vger.kernel.org
> Cc: Chanwoo Choi; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: dts: exynos4: clean up arm-pmu node
> 
> Hi Chanho,
> 
> On 14.04.2014 15:03, Chanho Park wrote:
> > This patch cleans a arm-pmu node up for exynos4. Only exynos4412
> series
> > boards have four pmu interrupts. Rest of exynos4 boards, except 4412,
> have only
> > two pmu interrupts. Thus, we can define two interrupts in the
> > exynos4.dtsi and extends the interrupts only exynos4412.dtsi.
> >
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > ---
> >   arch/arm/boot/dts/exynos4.dtsi    | 6 ++++++
> >   arch/arm/boot/dts/exynos4210.dtsi | 6 ------
> >   arch/arm/boot/dts/exynos4412.dtsi | 6 ++++++
> >   arch/arm/boot/dts/exynos4x12.dtsi | 6 ------
> >   4 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos4.dtsi
> b/arch/arm/boot/dts/exynos4.dtsi
> > index e541ecb..6de978c 100644
> > --- a/arch/arm/boot/dts/exynos4.dtsi
> > +++ b/arch/arm/boot/dts/exynos4.dtsi
> > @@ -105,6 +105,12 @@
> >   		reg = <0x10440000 0x1000>;
> >   	};
> >
> > +	pmu {
> > +		compatible = "arm,cortex-a9-pmu";
> > +		interrupt-parent = <&combiner>;
> > +		interrupts = <2 2>, <3 2>;
> > +	};
> > +
> >   	sys_reg: syscon at 10010000 {
> >   		compatible = "samsung,exynos4-sysreg", "syscon";
> >   		reg = <0x10010000 0x400>;
> > diff --git a/arch/arm/boot/dts/exynos4210.dtsi
> b/arch/arm/boot/dts/exynos4210.dtsi
> > index cacf614..4e7610f 100644
> > --- a/arch/arm/boot/dts/exynos4210.dtsi
> > +++ b/arch/arm/boot/dts/exynos4210.dtsi
> > @@ -75,12 +75,6 @@
> >   		#clock-cells = <1>;
> >   	};
> >
> > -	pmu {
> > -		compatible = "arm,cortex-a9-pmu";
> > -		interrupt-parent = <&combiner>;
> > -		interrupts = <2 2>, <3 2>;
> > -	};
> > -
> >   	pinctrl_0: pinctrl at 11400000 {
> >   		compatible = "samsung,exynos4210-pinctrl";
> >   		reg = <0x11400000 0x1000>;
> > diff --git a/arch/arm/boot/dts/exynos4412.dtsi
> b/arch/arm/boot/dts/exynos4412.dtsi
> > index 15d3c0a..e6af870 100644
> > --- a/arch/arm/boot/dts/exynos4412.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412.dtsi
> > @@ -26,6 +26,12 @@
> >   		samsung,combiner-nr = <20>;
> >   	};
> >
> > +	pmu {
> > +		compatible = "arm,cortex-a9-pmu";
> > +		interrupt-parent = <&combiner>;
> 
> I guess you could omit the two properties above and let them be
> inherited from exynos4.dtsi.

Yes. It can be omitted in the exynos4412.dtsi. Thank you for your review.
I'll send V2 Patch.

Best Regards,
Chanho Park
