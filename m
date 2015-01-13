From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Jan 2015 08:01:14 -0800
Subject: [PATCH v2] ARM: dts: cm-t3x: add NAND support
In-Reply-To: <54AE5C3F.7010306@ti.com>
References: <54A00BD6.8010507@compulab.co.il>
 <1419777049-25271-1-git-send-email-lifshitz@compulab.co.il>
 <54A151F2.9010904@ti.com> <54A25696.80608@compulab.co.il>
 <20150108001648.GQ13010@atomide.com> <54AE5C3F.7010306@ti.com>
Message-ID: <20150113160113.GE2419@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [150108 02:33]:
> On 08/01/15 02:16, Tony Lindgren wrote:
> > * Dmitry Lifshitz <lifshitz@compulab.co.il> [141229 23:42]:
> >> On 12/29/2014 03:06 PM, Roger Quadros wrote:
> >>> On 28/12/14 16:30, Dmitry Lifshitz wrote:
> >>>> --- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
> >>>> +++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
> >>>> @@ -50,7 +50,8 @@
> >>>>  #include "omap-gpmc-smsc911x.dtsi"
> >>>>
> >>>>  &gpmc {
> >>>> -	ranges = <5 0 0x2c000000 0x01000000>;
> >>>> +	ranges = <5 0 0x2c000000 0x01000000>, /* CM-T3x30 SMSC9x Eth */
> >>>> +		 <0 0 0x00000000 0x01000000>; /* CM-T3x NAND */
> >>>
> >>> Isn't this ranges property redundant as it will anyways be overridden by the board specific dts?
> >>>
> >>
> >> The ranges are specified here (and other files below) by design.
> >>
> >> We built a tree like structure to organize DT files -
> >> d234e4239 "ARM: dts: sbc-t3x: refactor DT support"
> >>
> >> It allows to inherit/override properties common for different boards.
> >>
> >> Our customers do not have to deal with a correct GPMC ranges settings, once
> >> they base on omap3-cm-t3x.dts core module DT file (in case they do not
> >> connect additional device to the bus).
> >>
> >> This is the point of Igor's comment to the previous patch version.
> > 
> > Roger, do you still have pending issues with this patch?
> 
> Sorry missed this one. Thanks for the explanations Dmitry.
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Applying into omap-for-v3.20/dt thanks.

Tony
