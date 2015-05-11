From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 11 May 2015 16:06:02 +0200
Subject: [PATCH 2/3] clocksource: exynos_mct: Staticize struct clocksource
In-Reply-To: <1430368973-23786-2-git-send-email-k.kozlowski@samsung.com>
References: <1430368973-23786-1-git-send-email-k.kozlowski@samsung.com>
 <1430368973-23786-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5550B74A.8010607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2015 06:42 AM, Krzysztof Kozlowski wrote:
> The struct clocksource 'mct_frc' is not exported and used outside so
> make it static.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Applied to my tree for 4.2

   -- Daniel

>   drivers/clocksource/exynos_mct.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 87c2e558c465..8b2a9fc66dcc 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -209,7 +209,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
>   	exynos4_mct_frc_start();
>   }
>
> -struct clocksource mct_frc = {
> +static struct clocksource mct_frc = {
>   	.name		= "mct-frc",
>   	.rating		= 400,
>   	.read		= exynos4_frc_read,
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
