From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 17 Jul 2014 15:15:52 +0200
Subject: [PATCH 1/3] ARM: EXYNOS: Move code from hotplug.c to platsmp.c
In-Reply-To: <1405520417-15027-1-git-send-email-k.kozlowski@samsung.com>
References: <1405520417-15027-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <53C7CC88.5040707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 16.07.2014 16:20, Krzysztof Kozlowski wrote:
> Cleanup a little the SMP/hotplug code for Exynos by:
> 1. Moving completely all functions from hotplug.c into the platsmp.c;
> 2. Deleting the hotplug.c file.
> 
> After recent cleanups (e.g. 75ad2ab28f0f "ARM: EXYNOS: use
> v7_exit_coherency_flush macro for cache disabling") there was only CPU
> power down related code in hotplug.c file. Keeping this file does not
> give any benefits.
> 
> The commit only moves code around with one additional observable change:
> the hotplug.c was compiled with custom CFLAGS (-march=armv7-a). These
> CFLAGS are not necessary any more.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/mach-exynos/Makefile  |  3 --
>  arch/arm/mach-exynos/common.h  |  2 -
>  arch/arm/mach-exynos/hotplug.c | 92 ------------------------------------------
>  arch/arm/mach-exynos/platsmp.c | 74 +++++++++++++++++++++++++++++++++
>  4 files changed, 74 insertions(+), 97 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/hotplug.c
> 

For this and remaining patches from this series:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
