From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 May 2014 14:29:42 -0700
Subject: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
In-Reply-To: <537615EA.3020809@ti.com>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com>
 <5373C78E.7040301@linaro.org> <5373C8E8.6040208@ti.com>
 <5373CBB9.40506@linaro.org> <5373DD94.8030208@ti.com>
 <5374F35E.5040900@ti.com> <5374FE61.50901@linaro.org>
 <5374FF5B.8050702@ti.com> <5375079E.3060305@ti.com>
 <537615EA.3020809@ti.com>
Message-ID: <20140516212942.GK12881@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [140516 06:43]:
> Tony,
> 
> On Thursday 15 May 2014 02:29 PM, Santosh Shilimkar wrote:
> > On Thursday 15 May 2014 01:54 PM, Santosh Shilimkar wrote:
> >> On Thursday 15 May 2014 01:50 PM, Daniel Lezcano wrote:
> >>> On 05/15/2014 07:03 PM, Santosh Shilimkar wrote:
> > 
> > [..]
> > 
> >>>>> With above mentioned change, it should work. Other alternatives is OMAP4 driver does
> >>>>> its won registration where it can start the timer. The way it was before the
> >>>>> consolidation.
> >>>>>
> >>>>> Ofcourse if you have better fix, then great.
> >>>>>
> >>>> What is your suggestion. We *must* fix the regression asap. I think
> >>>> $subject patch with an update to bctimer start under CPUIDLE_FLAG_COUPLED
> >>>> seems a good way forward.
> >>>>
> >>>> Do let me know.
> >>>
> >>> Did you see Alex Shi's email [cc'ed] ? Reverting this change makes the panda ES to hang.
> >>>
> >> The hang is definitely due to the bctimer not started. As I said, I assumed it was and
> >> then you corrected saying it is under the flag.
> >>
> >>> I am not convinced the culprit is this code you are trying to revert.
> >>>
> >> fair enough. Thats why I said if you have an alternative fix thats great.
> >>
> > For record, below is updated patch with bctimer started which
> > was missed in earlier version. I haven't tested it though.
> > 
> > Alex,
> > Please give a try with your test-case and see if you still see the hang.
> > Am just curious about your issue and hence the request..
> > 
> Alex tested below patch and he don't see the hang so the patch is
> addressing the issue.
> 
> If Daniel works out an alternate fix to avoid reverts, that will be great
> but if not, we should merge the below patch. I let you take call on it.
 
Daniel any news on this?

And just to recap, this problem can be reproduced with current
Linux next with omap2plus_defconfig with CONFIG_CPU_IDLE enabled. The
system should hang during the boot at some point.

And for the record, the omap3 hang fix is now posted to the lists as
"[PATCH] ARM: OMAP2+: Fix DMA hang after off-idle". This should not
have anything to do with the omap4 cpu_idle hang as omap4 does not
currently lose context during idle.

Regards,

Tony
