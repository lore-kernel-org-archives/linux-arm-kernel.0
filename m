From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Fri, 13 Mar 2015 12:44:06 -0700
Subject: [PATCH] pinctrl: mediatek: mt8135/mt8173: Fix build error due
 to missing include file
In-Reply-To: <1426143074.26140.0.camel@phoenix>
References: <1426143074.26140.0.camel@phoenix>
Message-ID: <1426275846.22708.5.camel@mussux00.eus.mediatek.inc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-03-12 at 14:51 +0800, Axel Lin wrote:
> Fix below build error:
>   CC      drivers/pinctrl/mediatek/pinctrl-mt8135.o
> In file included from drivers/pinctrl/mediatek/pinctrl-mt8135.c:24:0:
> drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h:19:32: fatal error: pinctrl-mtk-common.h: No such file or directory
> compilation terminated.
> make[3]: *** [drivers/pinctrl/mediatek/pinctrl-mt8135.o] Error 1
> make[2]: *** [drivers/pinctrl/mediatek] Error 2
> make[1]: *** [drivers/pinctrl] Error 2
> make: *** [drivers] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h | 2 +-
>  drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
> index 5019cef..e17aedb 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
> @@ -16,7 +16,7 @@
>  #define __PINCTRL_MTK_MT8135_H
>  
>  #include <linux/pinctrl/pinctrl.h>
> -#include <pinctrl-mtk-common.h>
> +#include "pinctrl-mtk-common.h"
>  
>  static const struct mtk_desc_pin mtk_pins_mt8135[] = {
>  	MTK_PIN(
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
> index c1a3ca0..13e5b68 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
> @@ -16,7 +16,7 @@
>  #define __PINCTRL_MTK_MT8173_H
>  
>  #include <linux/pinctrl/pinctrl.h>
> -#include <pinctrl-mtk-common.h>
> +#include "pinctrl-mtk-common.h"
>  
>  static const struct mtk_desc_pin mtk_pins_mt8173[] = {
>  	MTK_PIN(

Hi Axel,

Thank you very much.

Acked-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Hongzhou
