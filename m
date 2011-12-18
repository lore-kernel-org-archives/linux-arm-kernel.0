From: olof@lixom.net (Olof Johansson)
Date: Sat, 17 Dec 2011 16:57:02 -0800
Subject: [PATCH 0/9] arm/tegra: Various pinmux-related cleanups
In-Reply-To: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
References: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111218005702.GA4336@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 03:12:23PM -0700, Stephen Warren wrote:
> While working on switching Tegra to a new pinctrl-based pin mux driver,
> I made a bunch of small pinmux-related fixes; this patch series.
>
> This patch series will have a few small context conflicts with Peter
> De Schrijver's Tegra30 support. Peter's patch series should have
> priority over this one (i.e. be the one merged if it's difficult to
> merge both).

Contents of the series as a whole looks good to me, but I did notice a
bunch of section mismatches. Instead of commenting on the specific
ones, just compile with CONFIG_DEBUG_SECTION_MISMATCH=y and fix up the
new ones and repost, please. :)

> In particular:
> * My patch 3 "arm/tegra: Harmony PCIe: Don't touch pinmux" and Peter's
>   patch "arm/tegra: prepare pinmux code for multiple tegra variants"
>   will have context conflicts; I've described the best way to resolve
>   this in my patch's commit description.
> * This series edits board-dt.c whereas Peter's series renames that to
>   board-dt-tegra20.c. I assume git will handle this without any issue.
> * There may be other obvious context conflicts that should be trivial
>   to resolve.

The fixups were indeed trivial and no big deal, thanks for providing the
preferred resolutions and heads-up though.

> Following this series, I have 3 patches in my local tree:
>   arm/tegra: Select PINMUX Kconfig variables
>   arm/tegra: Switch to new pinctrl driver
>   arm/tegra: Remove pre-pinctrl pinmux driver
> 
> (all work in DT and non-DT on all supported Tegra20 boards)
> 
> I need to rebase those on top of Peter's patches (the first patch needs
> updates for Tegra30 support, the last patch needs to delete the new
> Tegra30 pinmux driver that Peter's series adds). It will also depend on
> the pinctrl subsystem, which is being merged for the first time in 3.3,
> and probably also patches to pinctrl that may only show up in 3.4. So,
> I'll probably hold off posting those patches for merge until after 3.3
> is out, but will probably send them out as a preview before that.

It's no problem to add a topic branch that has dependencies and make
sure it gets merged upstream with said dependencies resolved, as long as
they are on stable branches by then (i.e. that they won't be rebased). So
either way works, it's up to you.


-Olof
