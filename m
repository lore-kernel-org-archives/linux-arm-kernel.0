From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Apr 2012 09:31:35 +0200
Subject: [PATCH 1/1] pinctrl: fix compile error if not select PINMUX
 support
In-Reply-To: <1333616843-3607-1-git-send-email-b29396@freescale.com>
References: <1333616843-3607-1-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdbWm8DbN33FT2YONNYcq2M4KrK5VSf3Yo2p3YJXucoZ=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2012 at 11:07 AM, Dong Aisheng <b29396@freescale.com> wrote:

> From: Dong Aisheng <dong.aisheng@linaro.org>
>
> The pinctrl_register_mappings is defined in core.c, so change the dependent
> macro from CONFIG_MUX to CONFIG_PINCTRL.
>
> The compile error message is:
> drivers/pinctrl/core.c:886: error: redefinition of 'pinctrl_register_mappings'
> include/linux/pinctrl/machine.h:160: note: previous definition of 'pinctrl_register_mappings' was here
> make[2]: *** [drivers/pinctrl/core.o] Error 1
> make[1]: *** [drivers/pinctrl] Error 2
> make: *** [drivers] Error 2
>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

Thanks, applied.

(Catching up with the patch queue...)

Yours,
Linus Walleij
