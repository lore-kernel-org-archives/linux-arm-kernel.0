From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Nov 2011 20:57:20 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix compile error due to kfree
In-Reply-To: <1319838312-8205-1-git-send-email-jhbird.choi@gmail.com>
References: <1319838312-8205-1-git-send-email-jhbird.choi@gmail.com>
Message-ID: <004e01cc9956$93ad7f40$bb087dc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jhbird.choi at gmail.com wrote:
> 
> From: Jonghwan Choi <jhbird.choi@gmail.com>
> 
> Fix  implicit declaration of function 'kfree'
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@gmail.com>
> ---
>  arch/arm/plat-samsung/dev-backlight.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/dev-backlight.c
b/arch/arm/plat-samsung/dev-
> backlight.c
> index 3cedd4c..2adbeae 100644
> --- a/arch/arm/plat-samsung/dev-backlight.c
> +++ b/arch/arm/plat-samsung/dev-backlight.c
> @@ -14,6 +14,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/pwm_backlight.h>
> +#include <linux/slab.h>
> 
>  #include <plat/devs.h>
>  #include <plat/gpio-cfg.h>
> --
> 1.7.0.4

Yes, applied.

But would be better if you could add description in detail......

Fix following build error.
    arch/arm/plat-samsung/dev-backlight.c: In function 'samsung_bl_set':
    arch/arm/plat-samsung/dev-backlight.c:145: error: implicit declaration
of function 'kfree'

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
