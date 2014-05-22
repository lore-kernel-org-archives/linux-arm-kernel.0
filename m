From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 00:38:09 +0200
Subject: [PATCH] pinctrl: sunxi: fix pin numbers passed to register offset
 helpers
In-Reply-To: <1400772055-3852-1-git-send-email-wens@csie.org>
References: <1400772055-3852-1-git-send-email-wens@csie.org>
Message-ID: <CACRpkdb14bv83yu87aps6QhO-_Map87akt9Uc04VSr2a=ZzD3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 5:20 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> The pin numbers passed to sunxi_*_reg helpers to get the correct
> registers should be the pin offset for the PIO block, not the
> absolute number we use that is based on the alphanumeric labels
> Allwinner uses.
>
> This patch subtracts .pin_base from the pin number passed to these
> functions, so the driver accesses the correct registers.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Maxime, can I have your ACK on this patch, too?

Yours,
Linus Walleij
