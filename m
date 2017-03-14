From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Mar 2017 14:15:58 +0100
Subject: [PATCH] pinctrl: sunxi: select GPIOLIB
In-Reply-To: <20170228190815.10699-1-icenowy@aosc.xyz>
References: <20170228190815.10699-1-icenowy@aosc.xyz>
Message-ID: <CACRpkdawMd98EwnWjKbvsbMc0j_RjMG1qiJ5TGQC2KLLQuYOUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 8:08 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:

> Allwinner pin controllers are also GPIO controllers.
>
> Currently, if GPIOLIB is forgot to be chosen, the build of
> pinctrl-sunxi.c will fail for lacking a lot of gpiochip_* functions.
>
> Select GPIOLIB to ensure this driver can be built.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> This bug is found when I try to add sunxi drivers on an ARM64
> allnoconfig, in order to prove that sunxi-ng ccu driver depends on
> reset_controller framework.
>
> I proved the latter dependency, but how to satisfy it still needs
> some discussion.

Patch applied.

This is the right thing to do.

We used to have a restriction such that a pin control driver
could not simply select GPIOLIB, because the selection had
to be done from the platform instead.

But we have fixed that! We can now select GPIOLIB
directly from any driver that needs it.

Yours,
Linus Walleij
