From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Sep 2012 23:21:01 -0700
Subject: Status of arm-soc for 3.7
Message-ID: <CAOesGMjWcEXubD9ei+r=Xxz9KdJcFMsuk0pEN08nNsas8we3_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First, a heads up for those of you who were planning on coming with
late merge requests: Sorry, but we will probably hold off until 3.8.

We'll still take fixes and probably some small updates. But given all
the moves of platform data and other code shuffling in the tree for
this next merge window, merge conflicts and dependencies are stacking
up quickly right now. I don't want things to get out of control in
that area, which means no more major merges.

What's left to deal with is:

* smp_ops branch, since multiplatform depends on it to allow building
more than one platform.

* bcmring removal hasn't been applied yet, it's not really urgent and
the patches were line wrapped and I forgot about it before I merged
multiplatform and, well, it can just wait until 3.8 now.

* vt8500 device tree conversion had some comments on some of the
bindings. Since the pull request has already come in, I'll revisit it
if it looks like it won't be too messy to merge in.

Beyond that, let me know if you have already sent us a merge request
that we have missed.

Some quick stats:

590 non-merge changesets are queued up through 94 branch merges, which
is fewer patches but about the same number of merges as usual:
 1149 files changed, 29520 insertions(+), 35466 deletions(-)

The cleanup branch this release is substantial: 160 patches alone,
with a diffstat of:
 614 files changed, 9769 insertions(+), 20645 deletions(-)


Some highlights (I'm missing lots, but a few are):

One platform removal: pnx4008
One new platform: bcm2835
Lots of DT updates across the board this release. Tegra has removed
all board files and gone DT-only.
We have a new maintainer for KS8695 (Greg Ungerer) and renewed contributions.
Qualcomm has started cleaning out some stale code from the MSM
platforms, and begin device tree enablement for the latest families.
Exynos4 has been converted to pinctrl and gpiolib.
PRISM2 has DT bindings for pinctrl
The first interrupt controller driver has been added to /drivers/irqchip
OMAP internal bus has been added to /drivers/bus
Lots of moves of platform_data contents into include/linux/platform_data
Moves and removal of other mach-*/include files out of the way to
prepare for multiplatform
Initial multiplatform patch series from Rob Herring


Top 15 authors:

Tony Lindgren (46)
Arnd Bergmann (40)
Uwe Kleine-K?nig (37)
Rob Herring (35)
Shawn Guo (33)
Stephen Warren (27)
Fabio Estevam (23)
Stephen Boyd (20)
Bryan Wu (18)
Laxman Dewangan (18)
Linus Walleij (17)
Chao Xie (12)
Afzal Mohammed (10)
Igor Grinberg (9)
Paul Walmsley (9)


-Olof
