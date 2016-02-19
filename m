From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 19 Feb 2016 09:37:00 +0900
Subject: [PATCH 3/3] thermal: exynos: Defer probe if vtmu is present but
 not registered
In-Reply-To: <1455819551-4666-4-git-send-email-javier@osg.samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
 <1455819551-4666-4-git-send-email-javier@osg.samsung.com>
Message-ID: <56C663AC.7030601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.02.2016 03:19, Javier Martinez Canillas wrote:
> The driver doesn't check if the regulator_get_optional return value is
> -EPROBE_DEFER so it will wrongly assume that the regulator couldn't be
> found just because the regulator driver wasn't registered yet, i.e:
> 
> exynos-tmu 10060000.tmu: Regulator node (vtmu) not found
> 
> In this case the return value should be propagated to allow the driver
> probe function to be deferred until the regulator driver is registered.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/thermal/samsung/exynos_tmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
