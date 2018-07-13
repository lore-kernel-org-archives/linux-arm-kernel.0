From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Jul 2018 09:06:54 +0200
Subject: [PATCH] gpio: aspeed: fix compile testing warning
In-Reply-To: <34126dddef64a7669946c354d4dd9e2adfb3344f.camel@kernel.crashing.org>
References: <20180709145612.4166409-1-arnd@arndb.de>
 <34126dddef64a7669946c354d4dd9e2adfb3344f.camel@kernel.crashing.org>
Message-ID: <CACRpkdaLs6CGGa99kNVvBDxwGHLg==0ygUeDaZo_QTqoKGBQag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 1:53 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> On Mon, 2018-07-09 at 16:56 +0200, Arnd Bergmann wrote:
> > Gcc cannot always see that BUG_ON(1) is guaranteed to not
> > return, so we get a warning message in some configurations:
> >
> > drivers/gpio/gpio-aspeed.c: In function 'bank_reg':
> > drivers/gpio/gpio-aspeed.c:244:1: error: control reaches end of non-void function [-Werror=return-type]
> >
> > Using a plain BUG() is easier here and avoids the problem.
> >
> > Fixes: 44ddf559d579 ("gpio: aspeed: Rework register type accessors")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Linus, can you plonk that on top of the patches in that topic branch
> you created ?

I put it on top of my devel branch where I merged in the topic
branch.

As it's a fringe thing anyways I don't think we need to recreate the
topic branch for this.

Yours,
Linus Walleij
