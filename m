From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 10 Dec 2016 10:46:23 +0100
Subject: [RFC PATCH 15/23] arm: use kconfig fragments for ARCH_PXA
 defconfigs (part 1)
In-Reply-To: <1481027938-31831-16-git-send-email-b.zolnierkie@samsung.com>
 (Bartlomiej Zolnierkiewicz's message of "Tue, 06 Dec 2016 13:38:50
 +0100")
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
 <1481027938-31831-16-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <87a8c415hs.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:

> Replace [lpd270,lubbock,mainstone,pxa255-idp]_defconfig-s with
> a Makefile target using merge_config.
>
> The patch was verified with doing:
>
>     $ make [lpd270,...]_defconfig
>     $ make savedefconfig
>
> and comparing resulting defconfig files (before/after the patch).
>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Cyril Bur <cyrilbur@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Bartolomiej,

It's a bit hard to judge without any context for me, especially I'm receiving
patches 11 to 21 but not the others. I suppose the advantage of defconfig
fragments was already discussed somewhere, could you point me to that please ?

One small thing that could be improved is the "pxa_basic*" names.

I think pxa_basic1 is "pxa_refboards" or something like that, as these are the
initial reference designs as far as I know from Intel and validation vehicles
rather that form factors.

In the same way, pxa_basic2 is rather "pxa_sharpsl" as these are sharp designs.

And pxa_basic3 looks like Motorola platforms, so "pxa_motorola" perhaps ?

I noticed imote2.config ended up based on pxa_basic3, while I would have
expected it to be based on pxa_basic1 as it looks like a reference board to me
...

Cheers.

--
Robert
