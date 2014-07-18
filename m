From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 18 Jul 2014 11:49:03 +0200
Subject: [PATCH v2 6/7] ARM: dts: rockchip: add core rk3288 dtsi
In-Reply-To: <20140718093551.GE25180@leverpostej>
References: <4868343.UFgjaXesOn@diego> <14646641.DlFrJR068n@diego>
 <20140718093551.GE25180@leverpostej>
Message-ID: <1405681459.GZ6IZjzim5@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am Freitag, 18. Juli 2014, 10:35:52 schrieb Mark Rutland:
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               cpu at 500 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a12";
> > +                       reg = <0x500>;
> > +               };
> > +               cpu at 501 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a12";
> > +                       reg = <0x501>;
> > +               };
> > +               cpu at 502 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a12";
> > +                       reg = <0x502>;
> > +               };
> > +               cpu at 503 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a12";
> > +                       reg = <0x503>;
> 
> I take it that we can only use one of these for the moment? I didn't see
> the addition of any SMP code.
> 
> Or did I miss that?
> 
> [...]
> 
> > +       timer {
> > +               compatible = "arm,armv7-timer";
> > +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> > IRQ_TYPE_LEVEL_HIGH)>, +                            <GIC_PPI 14
> > (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>, +                       
> >     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>, +       
> >                     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> > IRQ_TYPE_LEVEL_HIGH)>; +               clock-frequency = <24000000>;
> > +       };
> 
> Please say you don't need this clock-frequency property.
> 
> It's a work-around at best, and you won't be able to use Hyp properly.
> I'd really like to discourage use of this property, especially as people
> seem to set it regardless of whether the hardware's correct...
> 
> What's the state of CNTFREQ and CNTVOFF, and is there any chance that
> these are sane?

Both issues you mention are actually connected - timer-issues in smp context 
due to CNTVOFF not being set correctly and CNTFREQ currently not being 
initialized.

I'm very hopeful that both should be resolved in the near future and Will 
should also be able to tell you more about this :-).
So for the short-term I guess the clock-frequency is needed, but we should be 
able to remove it again in the future, once the bootloader is doing the right 
thing.


Heiko
