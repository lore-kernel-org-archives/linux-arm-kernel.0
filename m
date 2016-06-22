From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jun 2016 12:33:31 +0200
Subject: [PATCH] ARM: Samsung: fix missing s5p_init_cpu() declaration
In-Reply-To: <1466511653-9295-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466511653-9295-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <576A697B.10204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2016 02:20 PM, Ben Dooks wrote:
> The declaration of s5p_init_cpu() in arch/arm/mach-exynos/common.h
> is not included in the platform file arch/arm/plat-samsung/cpu.c
> which generates a warning.
> 
> Fix the following warning by moving the declaration to somewhere
> both the machine and platform code can get to it, and including
> the right files as necessary:
> 
> arch/arm/plat-samsung/cpu.c:47:13: warning: symbol 's5p_init_cpu' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/mach-exynos/common.h            | 1 -
>  arch/arm/mach-exynos/exynos.c            | 1 +
>  arch/arm/plat-samsung/include/plat/cpu.h | 1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)

Thanks, applied for v4.8.

Best regards,
Krzysztof
