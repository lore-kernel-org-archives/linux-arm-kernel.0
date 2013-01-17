From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 14:36:00 +0100
Subject: [PATCH] ARM: remove unnecessary 'select GENERIC_GPIO'
In-Reply-To: <1358255616-3171-1-git-send-email-shawn.guo@linaro.org>
References: <1358255616-3171-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdYw6V_GGjBsj_bzzkmFVTamuMq2oMwYDKhjMrXeS5j+fQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 2:13 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The only use of GENERIC_GPIO (defined by architecture) in GPIO subsystem
> is being selected by GPIOLIB.  Also there are no any use of the option
> at architecture level. Only two sub-architectures shmobile and orion
> really use the option as below.
>
>   arch/arm/mach-shmobile/Makefile:obj-$(CONFIG_GENERIC_GPIO)      += $(pfc-y)
>   arch/arm/plat-orion/Makefile:orion-gpio-$(CONFIG_GENERIC_GPIO) += gpio.o
>
> Remove all those unnecessary sub-architecture level selection of
> GENERIC_GPIO, which are there only for confusing people.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
