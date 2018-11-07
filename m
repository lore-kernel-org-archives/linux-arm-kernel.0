From: sean.wang@kernel.org (Sean Wang)
Date: Wed, 7 Nov 2018 02:00:43 -0800
Subject: [PATCH] pinctrl: mediatek: Fix dependencies for EINT_MTK
In-Reply-To: <20181102025728.963-1-olof@lixom.net>
References: <20181102025728.963-1-olof@lixom.net>
Message-ID: <CAGp9Lzq3rgNs=uuXDVTurwgGrCjDQg=rje0rpetbzeMX7U-XLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the catch.

Acked-by: Sean Wang <sean.wang@kernel.org>

On Thu, Nov 1, 2018 at 7:57 PM Olof Johansson <olof@lixom.net> wrote:
>
> Fixes the following config-time warning:
>
> WARNING: unmet direct dependencies detected for EINT_MTK
>   Depends on [n]: PINCTRL [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n]) && (PINCTRL_MTK [=n] || PINCTRL_MTK_MOORE [=n] || COMPILE_TEST [=n])
>   Selected by [y]:
>   - PINCTRL_MTK_PARIS [=y] && PINCTRL [=y] && OF [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n])
>
> Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  drivers/pinctrl/mediatek/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 9d142e1da567..50efc9cc8ee7 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -3,7 +3,7 @@ menu "MediaTek pinctrl drivers"
>
>  config EINT_MTK
>         bool "MediaTek External Interrupt Support"
> -       depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || COMPILE_TEST
> +       depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || PINCTRL_MTK_PARIS || COMPILE_TEST
>         select GPIOLIB
>         select IRQ_DOMAIN
>
> --
> 2.11.0
>
