From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 21 May 2015 10:03:45 +0200
Subject: [PATCH v2 11/11] ARM: dts: mt8135-evbp1: Add pinctrl/GPIO node
 for mt6397.
In-Reply-To: <1432015882-8646-12-git-send-email-hongzhou.yang@mediatek.com>
References: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
 <1432015882-8646-12-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CABuKBeLgqhP=QHSKtV1ozanZLWwY8Byo3-1Su3v3FteMJcEEbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-19 8:11 GMT+02:00 Hongzhou Yang <hongzhou.yang@mediatek.com>:
> Add pinctrl and GPIO node to mt8135-evbp1.dts.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> ---
>  arch/arm/boot/dts/mt8135-evbp1.dts |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mt8135-evbp1.dts b/arch/arm/boot/dts/mt8135-evbp1.dts
> index 357a91f..332233b 100644
> --- a/arch/arm/boot/dts/mt8135-evbp1.dts
> +++ b/arch/arm/boot/dts/mt8135-evbp1.dts
> @@ -14,6 +14,7 @@
>
>  /dts-v1/;
>  #include "mt8135.dtsi"
> +#include <dt-bindings/pinctrl/mt6397-pinfunc.h>
>
>  / {
>         model = "MediaTek MT8135 evaluation board";
> @@ -28,6 +29,13 @@
>         pmic: mt6397 {
>                 compatible = "mediatek,mt6397";
>
> +               pio6397: pinctrl at c000 {
> +                       compatible = "mediatek,mt6397-pinctrl";
> +                       pins-are-numbered;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +               };
> +
>                 mt6397regulator: mt6397regulator {
>                         compatible = "mediatek,mt6397-regulator";
>

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

Linus, please take it through your tree.
Thanks.

-- 
motzblog.wordpress.com
