From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Mar 2015 08:53:03 -0800
Subject: [PATCH 0/2] fix ehrpwm tbclk data on am33xx and am43xx
In-Reply-To: <54ED7B4A.2030201@ti.com>
References: <1423546542-29664-1-git-send-email-vigneshr@ti.com>
 <20150224171546.GB28244@atomide.com> <54ED7B4A.2030201@ti.com>
Message-ID: <20150306165302.GP13520@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150224 23:39]:
> On 02/24/2015 07:15 PM, Tony Lindgren wrote:
> >* Vignesh R <vigneshr@ti.com> [150209 22:43]:
> >>In am33xx and am43xx, ehrpwm tbclk is derived from functional clock of
> >>PWMSS. The schematics and TRMs show that there is only one input clock to
> >>the PWMSS. But currently, tbclk is wrongly shown to be deriving from
> >>dpll_per_m2_ck instead of functional clock l4ls_gclk in the DT.
> >>
> >>Fixing ehrpwm tbclk data to reflect the right clk source.
> >>Tested on beaglebone and am437x-gp-evm.
> >>
> >>Vignesh R (2):
> >>   ARM: dts: am33xx-clocks: Fix ehrpwm tbclk data on am33xx
> >>   ARM: dts: am43xx-clocks: Fix ehrpwm tbclk data on am43xx
> >>
> >>  arch/arm/boot/dts/am33xx-clocks.dtsi |  6 +++---
> >>  arch/arm/boot/dts/am43xx-clocks.dtsi | 12 ++++++------
> >>  2 files changed, 9 insertions(+), 9 deletions(-)
> >
> >Tero, care to check this one too and ack if OK?
> 
> These look fine also, just verified from TRM. These two were actually buried
> in my mailbox, sorry about that.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Thanks applying both into omap-for-v4.0/fixes.

Tony 
