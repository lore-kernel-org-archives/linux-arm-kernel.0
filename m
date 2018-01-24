From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 24 Jan 2018 21:10:34 +0800
Subject: [RFC PATCH 0/9] initial support for "suniv" Allwinner new ARM9 SoC
In-Reply-To: <20180122121435.bpayxk4uzfqbhqse@flea.lan>
References: <20180119231735.61504-1-icenowy@aosc.io>
 <20180122121435.bpayxk4uzfqbhqse@flea.lan>
Message-ID: <14593819.uISRktVE4V@ice-x220i>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2018?1?22???? CST ??8:14:35?Maxime Ripard ???
> On Sat, Jan 20, 2018 at 07:17:26AM +0800, Icenowy Zheng wrote:
> > This is the RFC initial patchset for the "new" Allwinner SUNIV ARM9 SoC.
> > 
> > The same die is packaged differently, come with different co-packaged
> > DRAM or shipped with different SDK; and then made many model names: F23,
> > F25, F1C100A, F1C100S, F1C200S, F1C500, F1C600, R6, etc. These SoCs all
> > share a common feature set and are packaged similarly (eLQFP128 for SoCs
> > without co-packaged DRAM, QFN88 for with DRAM). As their's no
> > functionality hidden on the QFN88 models (except DRAM interface not
> > exported), it's not clever to differentiate them. So I will use suniv as
> > common name of all these SoCs.
> 
> Where is that suniv prefix coming from?

The BSP (Melis and Linux). (e.g. "libs/suniv" directory of the Melis SDK and 
"arch/arm/boot/dts/sunivw1p1.dtsi" in the Linux SDK)

> 
> And you need to have a SoC in all your compatibles. This isn't about
> being clever or not, this is just a matter of being able to accurately
> read in a crystal ball. Or maybe it's just the same, in which case,
> I'd really like to have a course :)

Okay. I will choose to use f1c100s in my next patchset, as it's where
it's developed. (Although I mainly refered F1C600 BSP and document)

> 
> You should really answer two questions here:
>   - Are you able to predict whether you'll find an SoC part of that
>     family in the future that derives a bit and will need a compatible
>     of its own?
>   - Are you able to predict which quirks we'll need along the way to
>     support all the SoCs you've listed there?
> 
> If you can't answer yes to both these questions, with a 100%
> certainty, then you'll need a SoC name in the compatible.
> 
> Which doesn't prevent you from sharing as much as possible the DT like
> we did between the A10s and the A13 for example.

So the suniv-f1c100s.dtsi will still be kept empty and all peripherals known 
should go through suniv.dtsi.

> 
> Maxime
