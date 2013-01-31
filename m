From: r.sh.open@gmail.com (Rahul Sharma)
Date: Thu, 31 Jan 2013 14:12:24 +0530
Subject: [PATCH 5/5] drm/exynos: don't include plat/gpio-cfg.h
In-Reply-To: <1359127711-19070-6-git-send-email-arnd@arndb.de>
References: <1359127711-19070-1-git-send-email-arnd@arndb.de>
 <1359127711-19070-6-git-send-email-arnd@arndb.de>
Message-ID: <CAPdUM4MbFN6htJ9Xa_OtdfgpxNH=7JD6-eUAkVM5_O5SZYv2+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd Bergmann,

It looks good to me. My patch caused this issue.
Thanks for the fix.

regards,
Rahul Sharma.

On Fri, Jan 25, 2013 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Patch  9eb3e9e6f3 "drm/exynos: add support for ARCH_MULTIPLATFORM"
> allowed building the exynos hdmi driver on non-samsung platforms,
> which unfortunately broke compilation in combination with 22c4f42897
> "drm: exynos: hdmi: add support for exynos5 hdmi", which added
> an inclusion of the samsung-specific plat/gpio-cfg.h header file.
>
> Fortunately, that header file is not required any more here, so
> we can simply revert the inclusion in order to build the ARM
> allyesconfig again without getting this error:
>
> drivers/gpu/drm/exynos/exynos_hdmi.c:37:27: fatal error: plat/gpio-cfg.h: No such file or directory
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Clark <rob@ti.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Rahul Sharma <rahul.sharma@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index 41ff79d..b5f5119 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -34,7 +34,6 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/io.h>
>  #include <linux/of_gpio.h>
> -#include <plat/gpio-cfg.h>
>
>  #include <drm/exynos_drm.h>
>
> --
> 1.8.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
