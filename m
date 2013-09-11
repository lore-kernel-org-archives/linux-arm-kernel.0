From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 11 Sep 2013 14:51:42 -0700
Subject: [PATCH] mtd: nand: pxa3xx: Add pxa3xx_nand_get_variant() stub
 for !CONFIG_OF
In-Reply-To: <20130911212300.GA21690@localhost>
References: <1378916185-19738-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAOesGMi00E-AFHRBZdkirECFoeO9FthPDSaeTCURBGQp-gpvWg@mail.gmail.com>
 <20130911205849.GA4550@ld-irv-0074.broadcom.com>
 <20130911212300.GA21690@localhost>
Message-ID: <20130911215142.GC4550@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 06:23:01PM -0300, Ezequiel Garcia wrote:
> On Wed, Sep 11, 2013 at 01:58:49PM -0700, Brian Norris wrote:
> > On Wed, Sep 11, 2013 at 09:27:11AM -0700, Olof Johansson wrote:
> > > On Wed, Sep 11, 2013 at 9:16 AM, Ezequiel Garcia
> > > <ezequiel.garcia@free-electrons.com> wrote:
> > > > This commit adds a dummy pxa3xx_nand_get_variant() stub, to fix
> > > > this build error (with pxa3xx_defconfig or similar):
> > > >
> > > > drivers/mtd/nand/pxa3xx_nand.c:1325:2: error: implicit declaration of
> > > > function 'pxa3xx_nand_get_variant' [-Werror=implicit-function-declaration]
> > > >
> > > > Cc: Brian Norris <computersforpeace@gmail.com>
> > > > Cc: David Woodhouse <dwmw2@infradead.org>
> > > > Cc: Olof Johansson <olof@lixom.net>
> > > > Cc: Kevin Hilman <khilman@linaro.org>
> > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > 
> > > Nack. This has already been fixed by you(!), Brian is just sitting on
> > > the patch and not sending it up for some reason. Brian?

...

> > Second, David hasn't authorized me to send pull requests, so I'm just
> > queueing things up for him. I don't know why David removed this patch
> > (among a few others) from his pull request.
> 
> As you may recall, we did the below patch because you (correctly) noticed
> it was possible to avoid the ifdef. It also fixed the build break, but nobody
> noticed that until just now, so nobody reported the patch was actually a fix.

Well, your series originally defined this stub function before I
recommended a change to drop the CONFIG_OF check. See your v2 patch:

  http://lists.infradead.org/pipermail/linux-mtd/2013-August/047863.html

So there never was a build breakage until David rebased; the patch was
just a dependent part of the series that should never have been
postponed.

Brian
