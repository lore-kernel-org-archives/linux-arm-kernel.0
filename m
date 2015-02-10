From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Feb 2015 16:17:03 +0800
Subject: [PATCH v5 3/5] ARM: mediatek: Add Pinctrl/GPIO driver for mt8135.
In-Reply-To: <1421818097-9281-4-git-send-email-hongzhou.yang@mediatek.com>
References: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
 <1421818097-9281-4-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdasVPUtn=-DhJ4OUXGZh36sLKwLhvm-nD-mkZjP7gQXww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 1:28 PM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> From: Hongzhou Yang <hongzhou.yang@mediatek.com>
>
> The mediatek SoCs have GPIO controller that handle both the muxing and GPIOs.
>
> The GPIO controller have pinmux, pull enable, pull select, direction and output high/low control.
>
> This driver include common driver and mt8135 part.
> The common driver include the pinctrl driver and GPIO driver.
> The mt8135 part contain its special device data.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

I have merged this patch for v3.21, except:

>  arch/arm/mach-mediatek/Kconfig                |    1 +
(...)
 --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -1,6 +1,7 @@
>  menuconfig ARCH_MEDIATEK
>         bool "Mediatek MT65xx & MT81xx SoC" if ARCH_MULTI_V7
>         select ARM_GIC
> +       select PINCTRL
>         select MTK_TIMER
>         help
>           Support for Mediatek MT65xx & MT81xx SoCs

This, which should come in through the ARM SoC tree. It's not
dependent on this series anyway.

This will appear after the merge window as we start the v3.21 cycle.

Yours,
Linus Walleij
