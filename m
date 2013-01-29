From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Jan 2013 23:40:34 +0100
Subject: [PATCH 1/5] ARM: sunxi: Increase the number of GPIOs available
In-Reply-To: <1359211016-24097-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1359211016-24097-1-git-send-email-maxime.ripard@free-electrons.com>
 <1359211016-24097-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdbZhS1APd6bFEnh9OLJEnNMgtFOCmW8vz1fVP3+yKy7LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 3:36 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The Allwinner A10 has 9 banks of 32 GPIOs available, so it doesn't fit
> in the usual 256 limit set by gpio.h. Increase this number to 288.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f95ba14..1e86fa9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1632,7 +1632,7 @@ config ARCH_NR_GPIO
>         default 355 if ARCH_U8500
>         default 264 if MACH_H4700
>         default 512 if SOC_OMAP5
> -       default 288 if ARCH_VT8500
> +       default 288 if ARCH_VT8500 || ARCH_SUNXI

Can I have an ACK from the ARM SoC maintainers on this?

Yours,
Linus Walleij
