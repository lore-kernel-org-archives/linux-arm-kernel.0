From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 19 Oct 2015 10:41:12 +0900
Subject: [PATCH] hwrng: exynos - Fix unbalanced PM runtime get/puts
In-Reply-To: <1445011311-32142-1-git-send-email-daniel.thompson@linaro.org>
References: <1445011311-32142-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <56244A38.4040207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.10.2015 01:01, Daniel Thompson wrote:
> Currently this driver calls pm_runtime_get_sync() rampantly
> but never puts anything back. This makes it impossible for the
> device to autosuspend properly; it will remain fully active
> after the first use.
> 
> Fix in the obvious way.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
> 
> Notes:
>     Compile tested only (CONFIG_PM=y, CONFIG_HW_RANDOM_EXYNOS=m); I spotted
>     this whilst reviewing the code and don't have an exynos platform to
>     test on.
> 
>  drivers/char/hw_random/exynos-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

To test the patch I had to add OF support to the driver. I have these
patches almost ready and I will send them soon. Anyway:

Tested on Trats2 board (Exynos4412):
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
