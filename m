From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 09 Dec 2013 16:06:58 -0800
Subject: [GIT PULL] two regression fixes and two more omap dt fixes
 against v3.13-rc2
In-Reply-To: <52a4fc3b.6494420a.5e2f.7338SMTPIN_ADDED_BROKEN@mx.google.com>
 (Tony Lindgren's message of "Sun, 8 Dec 2013 15:09:40 -0800")
References: <52a4fc3b.6494420a.5e2f.7338SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <87bo0p602l.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:
>
>   Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/yet-more-dt-regressions-take2
>
> for you to fetch changes up to f2e2c9d9b4087b74eb9e00d8dfac148354cb0b71:
>
>   ARM: dts: Fix booting for secure omaps (2013-12-06 15:30:43 -0800)
>
> ----------------------------------------------------------------
> A rather big fix for a regression where we have dropped omap4 hwmod
> data earlier but are not initializing it from device tree. In addition
> to this fix we eventually also be fix the issues in the .dts files
> and drivers, but that's too intrusive for the -rc cycle and must be
> done later on.
>
> Also a fix for a regression where we now are wrongly trying to initialize
> devices on secure omaps like n900 and n9* when booted using device tree.
> We need to set aes, sham and timer12 to disabled mode for secure
> devices as they are claimed by the firmware running in the secure mode.
>
> And two more legacy booting vs device tree based booting fixes for
> am3517 that I did not notice earlier until Nishant Menon reported
> these to me few days ago. With these we're good to go having v3.13
> working both for legacy booting and device tree based booting, and we
> can then go ahed and drop the legacy booting for mach-omap2 for v3.14.
>
> ----------------------------------------------------------------

Pulled into fixes,

Thanks,

Kevin
