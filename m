From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Jul 2014 23:44:42 +0200
Subject: [PATCH] pinctrl: sunxi: Fix multi bank interrupt support in
 gpio_to_irq
In-Reply-To: <1404144299-740-1-git-send-email-wens@csie.org>
References: <1404144299-740-1-git-send-email-wens@csie.org>
Message-ID: <CACRpkdaNdnCyKj6T5G6pvh4QCFjCjnOUYBjq=1Xyw6ySHKr_Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 6:04 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> When mapping the interrupts, the gpio_to_irq function did not consider
> the bank number of the gpio pin in question, only the offset or the
> interrupt number in the bank. As a result, requests for interrupts in
> the later banks get mapped to the first bank.
>
> This issue was discovered while enabling mmc on the new sun8i platform.
> The tablet I have uses a pin/interrupt from the second bank to do mmc
> card detection. Tested on this very device with register inspection and
> actual mmc card insertion/removal.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
