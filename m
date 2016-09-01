From: tony@atomide.com (Tony Lindgren)
Date: Thu, 1 Sep 2016 08:40:57 -0700
Subject: [GIT PULL] drop last omap3 board files for v4.8
In-Reply-To: <20160816155241.eka7c6p2rvp4q5zk@atomide.com>
References: <20160816155241.eka7c6p2rvp4q5zk@atomide.com>
Message-ID: <20160901154057.y6hib3ckdjppehfl@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Tony Lindgren <tony@atomide.com> [160816 08:53]:
> The following changes since commit 79cdad3635b3a253d712aba115fa274ef94a8c6b:
> 
>   ir-rx51: use hrtimer instead of dmtimer (2016-06-29 21:54:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.8/legacy-signed
> 
> for you to fetch changes up to e92fc4f04a34a407f5ff8acaa13127c62b7bec07:
> 
>   ARM: OMAP2+: Drop legacy board file for LDP (2016-07-10 23:47:38 -0700)
> 
> ----------------------------------------------------------------
> Remove the last two legacy board-*.c files for omap3 for legacy
> booting for v4.8 to allow making mach-omap2 device tree only for
> v4.9.
> 
> We've had Nokia N900 and omap3 LDP board-*.c files remaining
> while other omap3 devices have been device tree only for quite
> a while now. Also N900 and LDP have had device tree based booting
> working for years now, but few drivers for N900 were still only
> working in legacy only mode until recently. With the remaining
> issues out of the way, we discussed on the mailing lists that
> we're finally OK to remove the remaining board-*.c files.
> 
> For the timing of this pull request, I wanted to wait until
> v4.8-rc1 is out to make sure the legacy booting still works fine
> after the merge window before doing it.
> 
> And for v4.8, let's not touch any other platform data in case we
> still need to revert for some reason. This makes the revert just a
> question of adding back the legacy board-*.c files.
> 
> Then if no issues, we can remove the unused remaining platform
> data later on for v4.9.

Naturally this can wait for v4.9 merge window too if considered
too intrusive this late.

Regards,

Tony
