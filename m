From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Dec 2016 15:11:38 +0100
Subject: [PATCH 4/4] ARM: versatile: support configuring versatile machine
 for no-MMU
In-Reply-To: <1481093992-30520-2-git-send-email-gerg@uclinux.org>
References: <1481093992-30520-1-git-send-email-gerg@uclinux.org>
 <1481093992-30520-2-git-send-email-gerg@uclinux.org>
Message-ID: <CACRpkdZywn46QbnvKcN-jkt43Vf+GBSNQkLgnnNg-DC-8aSO5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 7, 2016 at 7:59 AM, Greg Ungerer <gerg@uclinux.org> wrote:

> The motivation for this is that the versatile machine is well supported
> in qemu. And this provides an excellent platform for development and
> testing no-MMU support on ARM in general.
>
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>

Pretty cool eh?

Have you tested it on real hardware?

Otherwise I can test it if I have a git branch
I can pull in and compile.

Another target I had in mind was the Integrator which
incidentally supports a bunch of the old noMMU core
tiles where we can swap in an ARM946, which I guess
could work with this?

> --- a/arch/arm/mach-versatile/Kconfig
> +++ b/arch/arm/mach-versatile/Kconfig
> @@ -1,12 +1,13 @@
>  config ARCH_VERSATILE
>         bool "ARM Ltd. Versatile family"
> -       depends on ARCH_MULTI_V5
> +       depends on ARCH_MULTI_V5 || ARM_SINGLE_ARMV5
>         select ARM_AMBA
>         select ARM_TIMER_SP804
>         select ARM_VIC
>         select CLKSRC_VERSATILE
>         select COMMON_CLK_VERSATILE
>         select CPU_ARM926T
> +       select GPIOLIB

Not really related but I don't mind.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
