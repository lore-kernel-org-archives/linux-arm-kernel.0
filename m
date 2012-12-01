From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Dec 2012 18:16:34 +0100
Subject: [RFC 1/2] clk: use struct clk only for external API
In-Reply-To: <1354103571-27394-1-git-send-email-rabin.vincent@stericsson.com>
References: <1354103571-27394-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <CACRpkdbq02xnVJ4tnZvOFsp8JuP6-F0KLKyyv9TgyY9dWSdDJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 12:52 PM, Rabin Vincent
<rabin.vincent@stericsson.com> wrote:

> In order to provide per-user accounting, this separates the struct clk
> used in the common clock framework into two structures 'struct clk_core'
> and 'struct clk'.  struct clk_core will be used for internal
> manipulation and struct clk will be used in the clock API
> implementation.
>
> In this patch, struct clk is simply renamed to struct clk_core and a new
> struct clk is implemented which simply wraps it.  In the next patch, the
> new struct clk will be used to implement per-user clock enable
> accounting.
>
> There is a rather hacky #define of clk_core to clk for the non-common
> clk case in order to avoid a mass rename of all clk non-common clk
> implementations.
>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>

I like the spirit of this and I think it was Thomas Gleixner who early
on strongly recommended that the struct be kept as private as possible.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
