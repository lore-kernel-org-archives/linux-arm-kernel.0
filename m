From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Oct 2012 14:01:46 +0200
Subject: [PATCH 1/1] gpio/at91: auto request and configure the pio as
 input when the interrupt is used via DT
In-Reply-To: <1351000601-3141-1-git-send-email-plagnioj@jcrosoft.com>
References: <1351000601-3141-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdaLB=SJwLAniyt9+Y22N3_3FoO4KWkhkhKQ=r24oTVZsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 3:56 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> If we do this
>
>         interrupt-parent = <&pioA>;
>         interrupts = <7 0x0>;
>
> The current core map the irq correctly but the gpio is not configured as input.
> The pinctrl configure the pin as gpio with the correct mux parameter but is
> not responsible to configure it as input.
>
> So do it during the xlate
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Applied to my at91 branch, thanks!

Yours,
Linus Walleij
