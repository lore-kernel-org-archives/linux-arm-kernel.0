From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 2 Nov 2011 09:45:11 +0200
Subject: [GIT PULL] hwspinlock changes for 3.2
In-Reply-To: <CAK=WgbZso1qk5XUTjB1bLXYbezv80SbgyEXJ3Q32U28+cQMfZA@mail.gmail.com>
References: <CAK=WgbZso1qk5XUTjB1bLXYbezv80SbgyEXJ3Q32U28+cQMfZA@mail.gmail.com>
Message-ID: <CAK=Wgbb9yfFeubc8jfTe5urMz4WoCpOL=LwP9=Lr7mYaWrt1Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 30, 2011 at 10:06 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Please pull from
>
> git://git.kernel.org/pub/scm/linux/kernel/git/ohad/hwspinlock.git for-linus
...
> All of the patches have been tested in linux-next and currently there
> are no merge conflicts, though I expect one to happen with the arm-sco
> tree, as reported (and fixed) by Stephen earlier this month (see
> http://www.spinics.net/lists/linux-next/msg16931.html).

Now that arm-soc is merged, I fixed the conflict with the hwspinlock
tree and pushed it (just for reference) at:

git://git.kernel.org/pub/scm/linux/kernel/git/ohad/hwspinlock.git
for-linus-merged

There also seems to be a (trivial) omap_hsmmc build issue which I've
fixed and pushed to that branch (Chris I'm also attaching it below in
case you prefer to take it through the mmc tree).

> the hwspinlock
> tree and its upstream path have only materialized quite late in the
> cycle (see https://lkml.org/lkml/2011/9/21/249)

Linus, in the aforementioned thread, Arnd, Tony and Linus W preferred
that I send you direct pull requests for hwspinlock changes, but were
also ok with other upstream paths (e.g. through the arm-soc or the
omap trees), so please express your preference :) I don't expect much
hwspinlock activity anytime soon (at least not until we'll get either
c6x support or additional u8500 functionality).

Thanks,
Ohad.

commit f6e49189a11622f8675bd386db560309a05e581a
Author: Ohad Ben-Cohen <ohad@wizery.com>
Date:   Wed Nov 2 08:57:23 2011 +0200

    mmc: omap_hsmmc: fix build

    Fix omap_hsmmc build issue that was introduced by commit a3c76eb
    "mmc: replace printk with appropriate display macro".

    Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e8ff123..101cd31 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host
                }
        } else {
                if (!host->protect_card) {
-                       pr_info"%s: cover is open, "
+                       pr_info("%s: cover is open, "
                                         "card is now inaccessible\n",
                                         mmc_hostname(host->mmc));
                        host->protect_card = 1;
