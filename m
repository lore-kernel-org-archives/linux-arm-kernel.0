From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 09:40:16 +0200
Subject: [PATCH 09/16] pinctrl: exynos: Use one IRQ domain per pin bank
In-Reply-To: <1349685556-23718-10-git-send-email-t.figa@samsung.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-10-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdbNHqwt2X-SNRv3=7Ca-WrDERb=t01K7pFuvRzTNk1+4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:

> Instead of registering one IRQ domain for all pin banks of a pin
> controller, this patch implements registration of per-bank domains.
>
> At a cost of a little memory overhead (~2.5KiB for all GPIO interrupts
> of Exynos4x12) it simplifies driver code and device tree sources,
> because GPIO interrupts can be now specified per banks.
>
> Example:
>         device {
>                 /* ... */
>                 interrupt-parent = <&gpa1>;
>                 interrupts = <3 0>;
>                 /* ... */
>         };
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>

This looks like a very good patch!
Can it be applied in isolation from the other patches?
Thomas A: can you ACK this?

Yours,
Linus Walleij
