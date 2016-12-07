From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Dec 2016 23:48:45 +0100
Subject: [PATCH] clk: uniphier: Fix build with gcc-4.4.
In-Reply-To: <20161206231642.GA4388@codeaurora.org>
References: <1480725436-9628-1-git-send-email-vlee@freedesktop.org>
 <CAK7LNATeswNhoFsA90k=qF4Jock0ytNT-pPT6j+0b9MJFJwu9Q@mail.gmail.com>
 <20161206231642.GA4388@codeaurora.org>
Message-ID: <13497466.7JOeCiPKAN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 6, 2016 3:16:42 PM CET Stephen Boyd wrote:
> On 12/03, Masahiro Yamada wrote:
> > 2016-12-03 9:37 GMT+09:00 Vinson Lee <vlee@freedesktop.org>:
> > > gcc-4.4 has issues with anonymous unions in initializers.
> > >
> > >   CC      drivers/clk/uniphier/clk-uniphier-sys.o
> > > drivers/clk/uniphier/clk-uniphier-sys.c:45: error: unknown field ?factor? specified in initializer
> > > 
> I'll go drop all three patches and wreck Andrew's merge of this
> patch to -mm.

While the specific bug is resolved now, I'm curious about the
motivation for the first fix: Vinson, are you actually using
a seven year old compiler to build modern kernels in order
to run them on real systems, or is this for the purpose of
build testing only?

It would be good to know if there are actual requirements
for using compilers this old (or even older, as according
to the README file, we theoretically support building even
with gcc-3.2 from 2002), in case we ever want to officially
raise the minimum required versions.

I see that gcc-4.3 builds an ARM defconfig kernel 17% faster than
gcc-7.0, which may be nice for build testing, but it also produces
thousands of false-positive warnings, which makes it rather
useless for actually finding bugs in build testing.

	Arnd
