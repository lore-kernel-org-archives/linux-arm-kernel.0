From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 2 Oct 2015 13:12:14 +0200
Subject: [PATCH] ARM: ux500: modify initial levelshifter status
In-Reply-To: <1442483427-10500-1-git-send-email-linus.walleij@linaro.org>
References: <1442483427-10500-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAPDyKFodbEDKTpqCrDShXAz3-KT2WO59cv4vuY59usb6zcdD4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 September 2015 at 11:50, Linus Walleij <linus.walleij@linaro.org> wrote:
> commit 1d8aca9df612f5751892fb2642d72536f2f48fd0
> "ARM: ux500: fix MMC/SD card regression"
> fixed broken the level shifter: it should be default ON
> but became default OFF.
>
> Fixes: 1d8aca9df612 "ARM: ux500: fix MMC/SD card regression"
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reported-and-tested-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/arm/boot/dts/ste-hrefv60plus.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
> index 810cda743b6d..9c2387b34d0c 100644
> --- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
> +++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
> @@ -56,7 +56,7 @@
>                                         /* VMMCI level-shifter enable */
>                                         default_hrefv60_cfg2 {
>                                                 pins = "GPIO169_D22";
> -                                               ste,config = <&gpio_out_lo>;
> +                                               ste,config = <&gpio_out_hi>;
>                                         };
>                                         /* VMMCI level-shifter voltage select */
>                                         default_hrefv60_cfg3 {
> --
> 2.4.3
>
