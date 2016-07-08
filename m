From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 08 Jul 2016 14:51:23 +0200
Subject: [PATCH 2/4] bindings: spi-samsung: add exynos5433 spi compatible
In-Reply-To: <1467980304-14093-3-git-send-email-andi.shyti@samsung.com>
References: <1467980304-14093-1-git-send-email-andi.shyti@samsung.com>
 <1467980304-14093-3-git-send-email-andi.shyti@samsung.com>
Message-ID: <577FA1CB.30805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2016 02:18 PM, Andi Shyti wrote:
> The samsung,exynos5433-spi has some peculiarities that bring the
> need of creating a new compatible in the binding.

That is not accurate. This for both: exynos5433 and exynos7.

> 
> One of those is the 3-clocks controller management where the spi
> is fed with three clocks: "spi", "busclkN" and "ioclk".
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-samsung.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
> index 6dbdeb3..d4294c7 100644
> --- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
> @@ -10,6 +10,7 @@ Required SoC Specific Properties:
>      - samsung,s3c6410-spi: for s3c6410 platforms
>      - samsung,s5pv210-spi: for s5pv210 and s5pc110 platforms
>      - samsung,exynos7-spi: for exynos7 platforms
> +    - samsung,exynos5433-spi: for exynos5433 compatible controllers

As I wrote offline, proper order (alpha-numerical), so 5 before 7.

>  
>  - reg: physical base address of the controller and length of memory mapped
>    region.
> 

Thanks for the patch, nice work. I see that you ignored parts of my
offline comments so I guess you leave that work to others (describe
required clock properties, deprecate exynos7-spi). I'll send the follow
up then.

Best regards,
Krzysztof
