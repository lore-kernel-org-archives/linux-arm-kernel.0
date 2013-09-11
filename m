From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 11 Sep 2013 18:23:01 -0300
Subject: [PATCH] mtd: nand: pxa3xx: Add pxa3xx_nand_get_variant() stub
 for !CONFIG_OF
In-Reply-To: <20130911205849.GA4550@ld-irv-0074.broadcom.com>
References: <1378916185-19738-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAOesGMi00E-AFHRBZdkirECFoeO9FthPDSaeTCURBGQp-gpvWg@mail.gmail.com>
 <20130911205849.GA4550@ld-irv-0074.broadcom.com>
Message-ID: <20130911212300.GA21690@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 01:58:49PM -0700, Brian Norris wrote:
> On Wed, Sep 11, 2013 at 09:27:11AM -0700, Olof Johansson wrote:
> > On Wed, Sep 11, 2013 at 9:16 AM, Ezequiel Garcia
> > <ezequiel.garcia@free-electrons.com> wrote:
> > > This commit adds a dummy pxa3xx_nand_get_variant() stub, to fix
> > > this build error (with pxa3xx_defconfig or similar):
> > >
> > > drivers/mtd/nand/pxa3xx_nand.c:1325:2: error: implicit declaration of
> > > function 'pxa3xx_nand_get_variant' [-Werror=implicit-function-declaration]
> > >
> > > Cc: Brian Norris <computersforpeace@gmail.com>
> > > Cc: David Woodhouse <dwmw2@infradead.org>
> > > Cc: Olof Johansson <olof@lixom.net>
> > > Cc: Kevin Hilman <khilman@linaro.org>
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > 
> > Nack. This has already been fixed by you(!), Brian is just sitting on
> > the patch and not sending it up for some reason. Brian?
> 
> First, Ezequiel, please CC linux-mtd when you send MTD patches. This
> didn't show up in my Maintainer inbox because I'm not an ARM maintainer
> (but you *did* CC their list) :)
> 

Argh! Sorry about that. I cooked the above one in a rush.

> Second, David hasn't authorized me to send pull requests, so I'm just
> queueing things up for him. I don't know why David removed this patch
> (among a few others) from his pull request.
> 

As you may recall, we did the below patch because you (correctly) noticed
it was possible to avoid the ifdef. It also fixed the build break, but nobody
noticed that until just now, so nobody reported the patch was actually a fix.

So, I guess David considered it was a less urgent fix and decided to postpone it.

> David, the following commit (currently in l2-mtd.git) was a dependency
> for the rest of the pxa3xx series you just sent upstream. You
> (inadvertently?) left it out when you rebased. Please send a pull
> request for 3.12-rcX with at least this patch:
> 
> commit c4287efe67c298b1304c613093371103ac1bbb98
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Mon Aug 12 14:14:46 2013 -0300
> 
>     mtd: nand: pxa3xx: Remove unneeded ifdef CONFIG_OF
>     
>     There's no need to enclose this code within idef CONFIG_OF,
>     because the OF framework provides no-op stubs if CONFIG_OF=n.
>     
>     Cc: devicetree at vger.kernel.org
>     Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>     Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> 
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
