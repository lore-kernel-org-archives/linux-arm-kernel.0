From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 20 May 2015 09:51:23 +0900
Subject: [PATCH v7 18/25] ARM: Exynos: pm_domains: register power domain
 driver from core_initcall
In-Reply-To: <1432041645-11172-19-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1432041645-11172-19-git-send-email-m.szyprowski@samsung.com>
Message-ID: <555BDA8B.30402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.05.2015 22:20, Marek Szyprowski wrote:
> SYSMMU devices are registered very early in arch_initcall, so ensure
> that they can get access to power domains by registering power domain
> driver from earlier initcall. This change requires dropping usage of the
> platform device associated with each power domain and replacing clock
> calls with respective of_clk_* equivalents.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mach-exynos/pm_domains.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

Looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
