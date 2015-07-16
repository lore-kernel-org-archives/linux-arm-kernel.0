From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 16 Jul 2015 22:44:11 +0800
Subject: [PATCH v3 4/5] ARM: dts: mt8135: enable basic SMP bringup for
 mt8135
In-Reply-To: <55A51A54.7000208@mentor.com>
References: <1436851111-2369-1-git-send-email-yingjoe.chen@mediatek.com>
 <1436851111-2369-5-git-send-email-yingjoe.chen@mediatek.com>
 <55A51A54.7000208@mentor.com>
Message-ID: <1437057851.19585.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-07-14 at 09:19 -0500, Nathan Lynch wrote:
> On 07/14/2015 12:18 AM, Yingjoe Chen wrote:
> > Add arch timer node to enable arch-timer support. MT8135 firmware
> > doesn't correctly setup arch-timer frequency and CNTVOFF, add
> > properties to workaround this.
> 
> [...]
> 
> >  
> > +	timer {
> > +		compatible = "arm,armv7-timer";
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> > +					  IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> > +					  IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
> > +					  IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> > +					  IRQ_TYPE_LEVEL_LOW)>;
> > +		clock-frequency = <13000000>;
> > +		arm,cpu-registers-not-fw-configured;
> 
> It's disappointing to see this property in new DTS submissions.  It
> prevents taking advantage of the VDSO for gettimeofday/clock_gettime.
> 

Hi,

I know. But unfortunately this is a more then 1 year SoC, so I can't do
anything to change this :(

Joe.C
