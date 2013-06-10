From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 14:29:17 +0200
Subject: [PATCH 2/2] ARM: nomadik: add the new clocks to the device tree
In-Reply-To: <CAJAp7Oji=+9PqwGkF84BRaxkFeeO_kWoY378Ur-A5z6G9Z5xSQ@mail.gmail.com>
References: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
 <1370775348-7440-2-git-send-email-linus.walleij@linaro.org>
 <201306091621.02506.arnd@arndb.de>
 <CAJAp7OiYZx46aWRsXc+CmS+5F0STz5P+rdYnJEoaRRMUnkD1Cg@mail.gmail.com>
 <CAJAp7Oji=+9PqwGkF84BRaxkFeeO_kWoY378Ur-A5z6G9Z5xSQ@mail.gmail.com>
Message-ID: <CACRpkdYwRuvY5DLuG6aBbNsf8S7jDN4BqQfmeZsQk_aCa33ZbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 7:12 AM, Bjorn Andersson <bjorn@kryo.se> wrote:

> While hacking on clock support for msm8960 the other day I did the
> same thing; I figured that providing clocks with descriptive names
> would be of great benefit while reading the dts.
>
> I had my uart device setup with:
> clocks = <&gsbi8_uart_clk>, <&gsbi8_p_clk>;
>
> However, all currently present clock bindings follow the pattern
> described by Arnd.
> Following this pattern my uart would be setup as:
> clocks = <&clks 42>, <&clks 44>;
>
> Needless to say there is no way to make sense of this without
> consulting the specific binding documentation. So, although your way
> of setting up the clock binding is not the standard way I do prefer
> it, but it comes with plenty extra nodes in the tree.

I agree. In my case this was just a side-effect of the different
bits in the register having different parents, so the common pattern
could not be used, but when looking at the end result it's strikingly
more readable than the cryptic numbers.

However it is possible to mitigate the latter by using the new DTS
preprocessor support like so:

#include <dt-bindings/clk/my-clocks.h>:

/* Clock IDs */
#define GSBI8_UART_CLK 42
#define GSBI8_P_CLK 44

(...)
clocks = <&clks GSBI8_UART_CLK>, <&clks GSBI8_P_CLK>;

Yours,
Linus Walleij
