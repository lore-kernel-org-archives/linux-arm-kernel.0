From: tony@atomide.com (Tony Lindgren)
Date: Mon, 27 Jun 2011 11:00:27 -0700
Subject: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D793464@dbde02.ent.ti.com>
References: <1309171009-8075-1-git-send-email-premi@ti.com>
	<20110627111556.GM23145@atomide.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D7933C0@dbde02.ent.ti.com>
	<20110627123140.GP23145@atomide.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D793464@dbde02.ent.ti.com>
Message-ID: <20110627180027.GR23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Premi, Sanjeev <premi@ti.com> [110627 06:24]:
> 
> [sp] While I take my time understanding things on devel-timer;
>      I had a quick question - at risk of being flamed.
> 
>      Adding a new machine ID would trickle to u-boot and same
>      uImage (default) may not work across board revisions.

Yes that's a hassle :( Until we have device tree, maybe see if
u-boot passes ATAG_REVISION that's available as system_rev in
kernel?
 
>      How does this scheme look like:
>      - GPTIMER1 is used as default - as it works for most boards.
>      - GPTIMER12 is used based on a static config option OR a
>        board specific bootarg
> 
>      I know both these options aren't general practice. Still
>      wanted to know your views in the current context.

Let's not do a Kconfig option, but a cmdline option should work
if done in a generic way. If you decide to go that way, then
please add that to timer.c against devel-timer branch.

Regards,

Tony
