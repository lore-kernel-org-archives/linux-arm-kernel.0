From: metan@ucw.cz (Cyril Hrubis)
Date: Tue, 12 Apr 2011 22:54:21 +0200
Subject: zaurus: mmcblk0: error -110
In-Reply-To: <m3oc4bxne1.fsf@pullcord.laptop.org>
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<m3aafvz30t.fsf@pullcord.laptop.org>
	<20110412193944.GC2665@atrey.karlin.mff.cuni.cz>
	<m3oc4bxne1.fsf@pullcord.laptop.org>
Message-ID: <20110412205421.GD2665@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> >> Your symptoms match the bug that was fixed by:
> >> 
> >> bad3babace2ee4d ("mmc: fix CONFIG_MMC_UNSAFE_RESUME regression")
> >> 
> >> but this fix made it into 2.6.38, so if you're using 2.6.38 final then
> >> you shouldn't be seeing this.  Could you confirm that you have this
> >> patch?
> >
> > It seems that the pxa tree I have is still based on 2.6.38-rc8.
> >
> > And yes, turning CONFIG_MMC_UNSAFE_RESUME off seems to fix that problem.
> >
> > I'll try to update the kernel tree and try again with CONFIG_MMC_UNSAFE_RESUME
> > enabled.
> 
> Okay, great.  It was introduced in 2.6.38-rc1 and fixed in 2.6.38 final.
>

Tried 2.6.39-rc3 both with and without CONFIG_MMC_UNSAFE_RESUME and the
insert/remove detection works but both with and without unsafe resume, if the
card is removed for more than second or two it fails to recognize the card
after insertion failing with:

mmc0: error -95 whilst initialising SD card

-- 
metan
