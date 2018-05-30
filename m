From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2018 09:29:24 +0200
Subject: linux-next: manual merge of the regulator tree with the arm-soc
 tree
In-Reply-To: <20180530150711.2c7c1fe9@canb.auug.org.au>
References: <20180530150711.2c7c1fe9@canb.auug.org.au>
Message-ID: <CACRpkdaotBXbA4pPFHRH0S1SF7-XX_T6yAOwZcbsR3RBcj+-=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 7:07 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
>
> Today's linux-next merge of the regulator tree got a conflict in:
>
>   arch/arm/mach-omap1/board-ams-delta.c
>
> between commit:
>
>   0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables")
>
> from the arm-soc tree and commit:
>
>   6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")
>
> from the regulator tree.
>
> I fixed it up (see below - it may be better done) and can carry the fix
> as necessary.


OMG that patch on a patch makes my head spin.

I think I just have to look at the eventual result in linux-next and see if
it makes proper sense, and rely on Janusz to test the result and help
to fix it up.

I was unaware of this concurrent gpiod conversion inside OMAP1 but
I'm happy to see that it happens. We might have some fallout, but I'm
sure Janusz is on top of things.

Yours,
Linus Walleij
