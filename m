From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 31 Jul 2015 09:38:16 +0900
Subject: [PATCH v2 1/2] ARM: EXYNOS: pd: fix potentian kfree() of ro memory
In-Reply-To: <1438301390-7397-2-git-send-email-vz@mleia.com>
References: <1438301390-7397-1-git-send-email-vz@mleia.com>
 <1438301390-7397-2-git-send-email-vz@mleia.com>
Message-ID: <55BAC378.80701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.07.2015 09:09, Vladimir Zapolskiy wrote:
> The change fixes a bug introduced by 2be2a3ff42a5, memory allocated
> by kstrdup_const() must be always deallocated with kfree_const(),
> otherwise there is a risk of kfree'ing ro memory.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 2be2a3ff42a5 ("ARM: EXYNOS: register power domain driver from core_initcall")
> ---
> Changes from v1 to v2:
> * split a single change v1 into two
> * added Fixes tag and Cc: <stable@vger.kernel.org>
> 
>  arch/arm/mach-exynos/pm_domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
