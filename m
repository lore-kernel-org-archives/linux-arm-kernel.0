From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Jun 2015 08:10:45 +0100
Subject: [PATCH 4/8] ARM: STi: STiH407: Provide a node for CPUFreq
In-Reply-To: <20150623021622.GA16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-5-git-send-email-lee.jones@linaro.org>
 <20150623021622.GA16776@linux>
Message-ID: <20150623071045.GC3245@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jun 2015, Viresh Kumar wrote:

> [Ccing Rob]

Rob is already Cc'ed.

> On 22-06-15, 16:43, Lee Jones wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407-family.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > index f48767e..f57fd83 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -98,6 +98,11 @@
> >  		ranges;
> >  		compatible = "simple-bus";
> >  
> > +		cpufreq {
> > +			compatible = "st,stih407-cpufreq";
> > +			st,syscfg = <&syscfg_core 0x8e0>;
> > +		};
> 
> These virtual nodes aren't allowed in DT and you have added them
> before the bindings patch :).

This isn't a virtual node, but you bring up a good point.

The compatible string should also contain "syscon".

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
