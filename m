From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 10 Dec 2012 10:53:09 +0900
Subject: [PATCH] samsung: Add missing include guard to gpio-core.h
In-Reply-To: <1354749432-6028-1-git-send-email-spang@chromium.org>
References: <1354749432-6028-1-git-send-email-spang@chromium.org>
Message-ID: <032201cdd679$1afe4230$50fac690$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Spang wrote:
> 
> Signed-off-by: Michael Spang <spang@chromium.org>
> ---
>  arch/arm/plat-samsung/include/plat/gpio-core.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h
> b/arch/arm/plat-samsung/include/plat/gpio-core.h
> index 1fe6917..8622c9a 100644
> --- a/arch/arm/plat-samsung/include/plat/gpio-core.h
> +++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
> @@ -11,6 +11,9 @@
>   * published by the Free Software Foundation.
>  */
> 
> +#ifndef __PLAT_SAMSUNG_GPIO_CORE_H
> +#define __PLAT_SAMSUNG_GPIO_CORE_H
> +
>  #define GPIOCON_OFF	(0x00)
>  #define GPIODAT_OFF	(0x04)
> 
> @@ -122,3 +125,5 @@ extern struct samsung_gpio_pm samsung_gpio_pm_4bit;
>  /* locking wrappers to deal with multiple access to the same gpio bank */
>  #define samsung_gpio_lock(_oc, _fl) spin_lock_irqsave(&(_oc)->lock, _fl)
>  #define samsung_gpio_unlock(_oc, _fl)
spin_unlock_irqrestore(&(_oc)->lock,
> _fl)
> +
> +#endif /* __PLAT_SAMSUNG_GPIO_CORE_H */
> --
> 1.7.7.3

Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
