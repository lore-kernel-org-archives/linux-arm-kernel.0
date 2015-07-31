From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 31 Jul 2015 09:39:02 +0900
Subject: [PATCH v2 2/2] ARM: EXYNOS: fix double of_node_put() on error path
In-Reply-To: <1438301390-7397-3-git-send-email-vz@mleia.com>
References: <1438301390-7397-1-git-send-email-vz@mleia.com>
 <1438301390-7397-3-git-send-email-vz@mleia.com>
Message-ID: <55BAC3A6.8080807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.07.2015 09:09, Vladimir Zapolskiy wrote:
> The change removes the second of_node_put(), if
> for_each_compatible_node() body execution is not terminated. This
> prevents from object refcounter overflow over zero in OF_DYNAMIC
> build.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
> Changes from v1 to v2:
> * split a single change v1 into two
> 
>  arch/arm/mach-exynos/pm_domains.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
