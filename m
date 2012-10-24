From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Oct 2012 09:44:08 +0200
Subject: [PATCH 1/1] gpio/at91: auto request and configure the pio as
 input when the interrupt is used via DT
In-Reply-To: <1351000601-3141-1-git-send-email-plagnioj@jcrosoft.com>
References: <1351000601-3141-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdY6xJt2Xob8DHF==LYxNMpocEkbEhy-8DmQpZjZ4VPOXw@mail.gmail.com>
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

Looks OK to me: do you want me to just apply it on my AT91 branch
on the pinctrl tree?

Yours,
Linus Walleij
