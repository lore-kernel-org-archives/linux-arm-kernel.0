From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 May 2012 00:24:06 +0800
Subject: [PATCH] PINCTRL: SiRF: add CSR SiRFprimaII GPIO driver depending
 on pinmux APIs
In-Reply-To: <CAGsJ_4zknQjNK6-T7+av1N=7gijZ821keM=qaDEJZ9zOfnLhkw@mail.gmail.com>
References: <1337670845-14572-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdZOTZaVp6rfuQvZaQyk0+zxeAjwHryBMYY-C1WVABaLLA@mail.gmail.com>
 <CAGsJ_4zknQjNK6-T7+av1N=7gijZ821keM=qaDEJZ9zOfnLhkw@mail.gmail.com>
Message-ID: <CACRpkdb=00UP3NaBj4NhVy0wYhwkqqRB5e3Gid5hcpVhxH0wYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 11:03 PM, Barry Song <21cnbao@gmail.com> wrote:
> 2012/5/24 Linus Walleij <linus.walleij@linaro.org>:

>> This is actually such a nice and clean cut that it can be put into
>> drivers/gpio, it's just using pinctrl, not sharing code or hardware
>> registers with it. (If I understand correctly.)
>
> it is actually one pinmux/gpio/irq controller. as you see, i am using
> the same dt node with pinctrl-sirf.c:
> static const struct of_device_id sgpio_of_match[] __devinitconst = {
> ? ? ? {.compatible = "sirf,prima2-gpio-pinmux", },
> ? ? ? {},
> };
>
> here i splitted into two files just for viewing, and at the same time,
> i remap the same memory twice in pinctrl-sirf.c and gpio-sirf.c. they
> share same memory area.

Hmmmm.... but do they ever write into the same registers?

> these codes might be in pinctrl-sirf.c directly?

That also works. If you want one hardware block to be handled by
one driver you should do that. But if the split version works you
can also do that, so I'm not sure.

Yours,
Linus Walleij
