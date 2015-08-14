From: Dongsheng.Wang@freescale.com (Wang Dongsheng)
Date: Fri, 14 Aug 2015 03:24:35 +0000
Subject: [PATCH v3 1/2] Documentation: DT: FTM: add FTM0 be used as alarm
 timer
In-Reply-To: <CALRxmdDGgYh+_cOPB43gyuZwu_zo+wE0qHh8nWJTjiQN__hZ3w@mail.gmail.com>
References: <1439352061-14656-1-git-send-email-dongsheng.wang@freescale.com>
 <CALRxmdDGgYh+_cOPB43gyuZwu_zo+wE0qHh8nWJTjiQN__hZ3w@mail.gmail.com>
Message-ID: <SN1PR0301MB16165DCFD09CEB424A91F79F9D7C0@SN1PR0301MB1616.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank Yoder,

Fix them in next version.

Regards,
-Dongsheng

> -----Original Message-----
> From: Stuart Yoder [mailto:b08248 at gmail.com]
> Sent: Friday, August 14, 2015 12:23 AM
> To: Wang Dongsheng-B40534
> Cc: shawn.guo at linaro.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Wang Huan-B18965
> Subject: Re: [PATCH v3 1/2] Documentation: DT: FTM: add FTM0 be used as alarm
> timer
> 
> On Tue, Aug 11, 2015 at 11:01 PM, Dongsheng Wang
> <dongsheng.wang@freescale.com> wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > In freescale layerscape platform there is only FTM0 can be used as
> > alarm timer to wake up system. So add FTM0 description for devicetree
> > document.
> 
> Suggestion:
> 
> In the Freescale Layerscape platform a flextimer module can be used
> as an alarm timer to wake up the system.  Define a binding for this
> alarm.
> 
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > ---
> > V3:
> > Include this patch in V3.
> >
> > diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> > index aa8c402..380a0b3d 100644
> > --- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> > +++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> > @@ -1,5 +1,7 @@
> >  Freescale FlexTimer Module (FTM) Timer
> >
> > +* Default FTM Timer
> > +
> >  Required properties:
> >
> >  - compatible : should be "fsl,ftm-timer"
> > @@ -29,3 +31,26 @@ ftm: ftm at 400b8000 {
> >                 <&clks VF610_CLK_FTM3_EXT_FIX_EN>;
> >         big-endian;
> >  };
> > +
> > +* FTM Alarm Timer
> > +  The default FTM device contains eight FlexTimer modules. FlexTimer1 is in
> > +  on-domain(power is not switched off in deep sleep mode). Other seven
> FlexTimer
> > +  modules(flextimer2/3/4/5/6/7/8) are in off-domain (power is switched off in
> > +  deep sleep mode).
> 
> Suggestion:
> 
>   This binding describes a Flextimer (FTM) instance that can be used as an alarm
>   to wake up a system in deep sleep.  The flextimer module with alarm
>   support is in a power domain that remains awake when the SoC is in
>   deep sleep mode.
> 
> (don't use flextimer1 in the binding...for all you know in the next SoC it
> will be flextimer7 that has this capability)
> 
> > +Required properties:
> > +
> > +- compatible : should be "fsl,ftm-alarm".
> > +- reg : should contain base address and length of FTM timer 0 register.
> 
>   "should contain the address and size of the FTM alarm module registers"
> 
> (don't use the number 0)
> 
> > +- interrupts : Should contain FTM 0 interrupt.
> 
>    "describes the FTM alarm interrupt"
> 
> > +- big-endian: One boolean property, the big endian mode will be in use if it
> is
> > +  present, or the little endian mode will be in use for all the device
> registers.
> > +
> > +Example:
> > +ftm0: ftm0 at 29d0000 {
> > +       compatible = "fsl,ftm-alarm";
> > +       reg = <0x0 0x29d0000 0x0 0x10000>;
> > +       interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> > +       big-endian;
> > +       status = "disabled";
> > +};
> 
> Drop the number 0 from the names in your example.
> 
> Thanks,
> Stuart
