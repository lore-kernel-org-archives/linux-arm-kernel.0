From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Feb 2014 19:38:42 +0100
Subject: [PATCH v3 00/13] pinctrl: mvebu: restructure resource allocation
In-Reply-To: <52FCFC97.8050200@gmail.com>
References: <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140213172620.76e760ba@skate> <52FCF59E.3090100@gmail.com>
 <20140213175914.205803a6@skate> <52FCFC97.8050200@gmail.com>
Message-ID: <20140213193842.395994e5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Thu, 13 Feb 2014 18:10:47 +0100, Sebastian Hesselbarth wrote:
> >>> I am not sure what you mean here in terms of the ordering for the
> >>> patches. I'm attaching several patches, and the first three patches
> >>> adapt your patch series to also cover 375 and 38x, assuming the pinctrl
> >>> support for 375 and 38x is merged before your patch series.
> >>
> >> Right. If 375/38x pinctrl goes in first (what I expect), I'd have to add
> >> corresponding patches. You already sent them, I'll pick them up.
> >
> > Ok, cool. Hopefully we can sort out the merging of those two patch
> > series for 3.15 with Linus Walleij.
> 
> That is the plan - or rather get his Acked-by as we are lucky to have
> pinctrl/mvebu and touching nothing else.

Right.

> > You can take this opportunity to generate:
> >
> > 	{ "mpp0", ... },
> > 	{ "mpp1", ... },
> > 	{ "mpp2", ... },
> > 	...
> > 	{ "mpp65", ... },
> 
> Ah, ok, I see. Yes that should be doable. We should definitely consider
> this for later, i.e. leave it now as is and rework later.

Sure, as I said, I don't think we should do all the possible
improvements right now. Your patch series is already large enough :-)

That being said, I haven't looked very closely at the Dove pinctrl
driver, and this is the one that does the most funky things, with those
cases where multiple pins are muxed with a single register control.


> > static int armada_370_mpp_ctrl_get(unsigned pid, unsigned long *config)
> > {
> > 	return default_mpp_ctrl_get(mpp_base, pid, config);
> > }
> >
> > static int armada_370_mpp_ctrl_set(unsigned pid, unsigned long config)
> > {
> > 	return default_mpp_ctrl_set(mpp_base, pid, config);
> > }
> >
> > but we admittedly cannot completely remove the per-SoC function, since
> > the mpp_base is now only known to each per-SoC driver.
> 
> I guess I'll squash the above in for v4.. doesn't look that bad.

Cool, thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
