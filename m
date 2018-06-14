From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Jun 2018 10:33:32 +0200
Subject: [PATCH] pinctrl: pinctrl-single: Avoid divisions in context
 save/restore
In-Reply-To: <1528374274-26385-1-git-send-email-geert+renesas@glider.be>
References: <1528374274-26385-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CACRpkdYo9Tmes7sXCFWSMKpYXpEKDXkfqp33EBHziHeT=CpdfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2018 at 2:24 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The divisions (and multiplications) can be avoided by changing the loops
> to use increments of mux_bytes instead of 1.
> While at it, remove the unneeded casts when assigning void pointers.
>
> This saves +100 bytes of kernel size on arm32/arm64.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied for v4.19.

Yours,
Linus Walleij
