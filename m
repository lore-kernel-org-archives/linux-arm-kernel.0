From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 17 Jul 2010 13:31:48 +0200
Subject: [PATCH 1/2] MISC: driver for the character LCD found in ARM
	refdesigns
In-Reply-To: <1279365780-18462-1-git-send-email-triad@df.lth.se>
References: <1279365780-18462-1-git-send-email-triad@df.lth.se>
Message-ID: <AANLkTinDXAG9SzS1WFSyMvMAKTlYaVI362hDaravQYlQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/17 Linus Walleij <triad@df.lth.se>:

> This adds a driver for the character LCD found on the ARM Versatile
> and RealView Platform Baseboards. It doesn't do very much more than
> display the text "ARM Linux" on the first line and the linux banner
> on the second line, but that's still useful.

Some rebasing lost the commit comments after the patch...

We discussed the placement of this driver on the ARM Linux kernel
mailing list, originally it was in arch/arm/common, with arch/arm/plat-versatile
recommended if it should stay in the arch/arm tree.

However the overpopulation in arch/arm lead us to try and push it
into drivers/.

Other alternatives to drivers/misc:

- Create drivers/platform/arm and put it there
- Create drivers/lcd and hope for more LCD drivers
- Keep it in arch/arm/plat-versatile/

Andrew, since you seem to keep an eye on drivers/misc, is it OK
to merge this through Russells tree if the placement here is agreed
upon?

Yours,
Linus Walleij
