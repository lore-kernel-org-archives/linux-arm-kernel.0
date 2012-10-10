From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 09:43:25 +0200
Subject: [PATCH 11/16] pinctrl: samsung: Use one GPIO chip per pin bank
In-Reply-To: <1349685556-23718-12-git-send-email-t.figa@samsung.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-12-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdY3rk41xDQbG9Ft8iVYZnyk3vu3Fs9Ehin2Q1oSZ3JO-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:

> This patch modifies the pinctrl-samsung driver to register one GPIO chip
> per pin bank, instead of a single chip for all pin banks of the
> controller.
>
> It simplifies GPIO accesses a lot (constant time instead of looping
> through the list of banks to find the right one) and should have a good
> effect on performance of any bit-banging driver.
>
> In addition it allows to reference GPIO pins by a phandle to the bank
> node and a local pin offset inside of the bank (similar to previous
> gpiolib driver), which is more clear and readable than using indices
> relative to the whole pin controller.
>
> Example:
>         device {
>                 /* ... */
>                 gpios = <&gpk0 4 0>;
>                 /* ... */
>         };
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>

This also looks good (and I think it has been discussed before)
so needs to be applied in isolation from the regs-to-DT stuff.

Yours,
Linus Walleij
