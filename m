From: cjb@laptop.org (Chris Ball)
Date: Tue, 12 Apr 2011 17:21:15 -0400
Subject: zaurus: mmcblk0: error -110
In-Reply-To: <20110412205421.GD2665@atrey.karlin.mff.cuni.cz> (Cyril Hrubis's
	message of "Tue, 12 Apr 2011 22:54:21 +0200")
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<m3aafvz30t.fsf@pullcord.laptop.org>
	<20110412193944.GC2665@atrey.karlin.mff.cuni.cz>
	<m3oc4bxne1.fsf@pullcord.laptop.org>
	<20110412205421.GD2665@atrey.karlin.mff.cuni.cz>
Message-ID: <m3fwpnxj1w.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 12 2011, Cyril Hrubis wrote:
> Tried 2.6.39-rc3 both with and without CONFIG_MMC_UNSAFE_RESUME and the
> insert/remove detection works but both with and without unsafe resume, if the
> card is removed for more than second or two it fails to recognize the card
> after insertion failing with:
>
> mmc0: error -95 whilst initialising SD card

That's interesting.  Would you mind trying to bisect?  (Knowing whether
2.6.38 final does it, for example, would be very helpful.)

There aren't many -EOPNOTSUPP returns in the stack.  I see:

card/block.c: mmc_blk_issue_secdiscard_rq and mmc_blk_issue_discard_rq
card/core.c: mmc_erase
core/sd_ops.c: mmc_app_cmd

Mind doing some instrumentation to figure out which it is?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
