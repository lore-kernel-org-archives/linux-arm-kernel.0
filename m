From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 12 Nov 2012 10:40:13 +0000
Subject: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
In-Reply-To: <50A0A44B.6080604@compulab.co.il>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
 <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il>
 <509BDAF5.1010703@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB68589@DBDE01.ent.ti.com>
 <509BEE6D.9000902@ti.com>
 <alpine.DEB.2.00.1211081754390.20703@utopia.booyaka.com>
 <509BF525.80309@ti.com>
 <alpine.DEB.2.00.1211081809470.20703@utopia.booyaka.com>
 <509BFB4E.2090802@ti.com> <509F8D6B.5070504@compulab.co.il>
 <79CD15C6BA57404B839C016229A409A83EB70E88@DBDE01.ent.ti.com>
 <50A0A44B.6080604@compulab.co.il>
Message-ID: <79CD15C6BA57404B839C016229A409A83EB71362@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 12:54:59, Igor Grinberg wrote:
> On 11/12/12 08:38, Hiremath, Vaibhav wrote:
> > On Sun, Nov 11, 2012 at 17:05:07, Igor Grinberg wrote:
> >>
> >>
> >> On 11/08/12 20:34, Jon Hunter wrote:
> >>>
> >>> On 11/08/2012 12:17 PM, Paul Walmsley wrote:
> >>>> On Thu, 8 Nov 2012, Jon Hunter wrote:
> >>>>
> >>>>> On 11/08/2012 11:58 AM, Paul Walmsley wrote:
> >>>>>> On Thu, 8 Nov 2012, Jon Hunter wrote:
> >>>>>>
> >>>>>>> Igor was mentioning a h/w scenario where the 32kHz source is not
> >>>>>>> present. However, I am not sure which devices support this and is
> >>>>>>> applicable too.
> >>>>>>
> >>>>>> Pretty sure Igor is referring to the AM3517/3505.  This is very poorly 
> >>>>>> documented, but can be observed in the AM3517 TRM Rev B (SPRUGR0B) Figure 
> >>>>>> 4-23 "PRM Clock Generator" and the AM3517 DM Rev C (SPRS550C) Section 4 
> >>>>>> "Clock Specifications".
> >>>>>
> >>>>> But AFAICT, even in that h/w configuration the internal 32k
> >>>>> oscillator will be used
> >>>>
> >>>> Just to clarify, there's no internal 32k oscillator used on the 3517/3505; 
> >>>> just a divider from the HF clock.
> >>>
> >>> Ah yes I see that now!
> >>>
> >>>>> and so the gptimer will still have a 32k clock source.
> >>>>
> >>>> That's a good question and you might want to check with Igor on that one,
> >>>> the AM3517 TRM conflicts with the DM as to whether it's available to the 
> >>>> GPTIMER or not :-(
> >>>
> >>> Well the external 32k and internal divided down version go through the
> >>> same mux and so that seems to imply either they are both available to
> >>> the gptimer or neither is.
> >>
> >> Yep, but the /800 do not get you the 32768...
> >> and that makes the timer suck.
> >> Of course this can be dealt with in the clock subsystem
> >> (I remember Paul said that he will look into that), but it will take time.
> >>
> >> Also, what about having the sys_clk instead of 32k for higher precision?
> >> Is that possible already (without my patch)?
> >>
> > 
> > Yes, it is possible. You can choose it through bootargs.
> 
> Is the kernel command line the only way for doing this?
> I personally dislike it, because it brings multiple maintenance problems.
> This must be possible at least through DT.
> 

Its standard interface, so carries all the applicable pros and cons.
I am not quite sure about runtime change of clocksoyrce, its pros and cons.

Thanks,
Vaibhav

> 
> -- 
> Regards,
> Igor.
> 
