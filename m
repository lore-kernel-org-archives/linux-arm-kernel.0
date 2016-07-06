From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 6 Jul 2016 08:47:21 +0200
Subject: [PATCH 1/2] soc: samsung: Change type of PMU configuration
 register value to u32
In-Reply-To: <1467750507-13853-2-git-send-email-a.kesavan@samsung.com>
References: <1467750507-13853-1-git-send-email-a.kesavan@samsung.com>
 <1467750507-13853-2-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAJKOXPdPa7vCqetd5EUb3ebz7rB741ua=9wbdx-MkFh+G-=CJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2016 at 10:28 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> Exynos7 has certain PMU registers that needs to be configured with
> u32 values.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  drivers/soc/samsung/exynos-pmu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
> index a469e36..1bdc506 100644
> --- a/drivers/soc/samsung/exynos-pmu.h
> +++ b/drivers/soc/samsung/exynos-pmu.h
> @@ -18,7 +18,7 @@
>
>  struct exynos_pmu_conf {
>         unsigned int offset;
> -       u8 val[NUM_SYS_POWERDOWN];
> +       unsigned int val[NUM_SYS_POWERDOWN];

You mentioned u32 but I see unsigned int here. This should be u32.

BTW, none of your emails reached my samsung inbox. I got them only
from the lists. Please investigate why this couldn't be delivered to
samsung.com address.

Best regards,
Krzysztof
