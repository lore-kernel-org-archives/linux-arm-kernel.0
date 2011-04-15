From: metan@ucw.cz (Cyril Hrubis)
Date: Fri, 15 Apr 2011 23:33:15 +0200
Subject: zaurus: mmcblk0: error -110
In-Reply-To: <m339lnxes6.fsf@pullcord.laptop.org>
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<m3aafvz30t.fsf@pullcord.laptop.org>
	<20110412193944.GC2665@atrey.karlin.mff.cuni.cz>
	<m3oc4bxne1.fsf@pullcord.laptop.org>
	<20110412205421.GD2665@atrey.karlin.mff.cuni.cz>
	<m3fwpnxj1w.fsf@pullcord.laptop.org>
	<20110412224333.GA22640@atrey.karlin.mff.cuni.cz>
	<m339lnxes6.fsf@pullcord.laptop.org>
Message-ID: <20110415213315.GA4420@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> >> > mmc0: error -95 whilst initialising SD card
> >> 
> >> That's interesting.  Would you mind trying to bisect?  (Knowing whether
> >> 2.6.38 final does it, for example, would be very helpful.)
> >
> > It may need one or two tries on 2.6.38 but it's there too.
> >
> >> There aren't many -EOPNOTSUPP returns in the stack.  I see:
> >> 
> >> card/block.c: mmc_blk_issue_secdiscard_rq and mmc_blk_issue_discard_rq
> >> card/core.c: mmc_erase
> >> core/sd_ops.c: mmc_app_cmd
> >> 
> >> Mind doing some instrumentation to figure out which it is?
> >
> > Fails in the mmc_app_cmd.
> 
> Okay.  mmc_app_cmd() hasn't changed for years, so I'm afraid I don't
> have any strong leads for you -- further bisection (you're pretty
> sure this is a regression?) would be very useful.

Well, I was using some old kernel there and updated to the 2.6.38 recently so
only clue I do have is that it was working on like 2 years old kernel.

And bisection is quite complicated, as number of kernel images simply doesn't
boot there. :(

I will look on this next week (hopefully) thanks anyway for your help so far.

-- 
metan
