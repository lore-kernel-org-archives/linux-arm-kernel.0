From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Oct 2014 11:28:58 +0100
Subject: [PATCH] ARM: l2c: Make l2x0_cache_size_of_parse() return 'int'
In-Reply-To: <1414238792-13811-1-git-send-email-festevam@gmail.com>
References: <1414238792-13811-1-git-send-email-festevam@gmail.com>
Message-ID: <CACRpkdZsCWeXbtpide-FqMO+0YoCKKaz23JUwZyuObawyZLQ2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 25, 2014 at 2:06 PM, Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Since commit f3354ab67476dc80 ("ARM: 8169/1: l2c: parse cache properties from
> ePAPR definitions") the following error is seen on imx6q:
>
> [    0.000000] PL310 OF: cache setting yield illegal associativity
> [    0.000000] PL310 OF: -2147097556 calculated, only 8 and 16 legal
>
> As imx6q does not pass the "cache-size" and "cache-sets" properties in DT, the
> function l2x0_cache_size_of_parse() returns early and keep the 'associativity'
> pointer uninitialized.
>
> To fix this problem, return error codes inside l2x0_cache_size_of_parse() and
> only use the 'associativity' pointer result if l2x0_cache_size_of_parse()
> succeeds.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through Russell's patch tracker.

Yours,
Linus Walleij
