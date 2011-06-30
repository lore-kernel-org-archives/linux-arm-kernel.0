From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 15:54:37 +0900
Subject: [PATCH 1/7] ARM: EXYNOS4: Add external GIC io memory mapping
In-Reply-To: <1308555258-4322-2-git-send-email-chaos.youn@samsung.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
	<1308555258-4322-2-git-send-email-chaos.youn@samsung.com>
Message-ID: <BANLkTikYvCVVZP+z06466x1maEi3CDcq5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 4:34 PM, Changhwan Youn <chaos.youn@samsung.com> wrote:
> This patch adds external GIC io memory mapping
> to support external GIC on EXYNOS4.
>
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> ---
> ?arch/arm/mach-exynos4/cpu.c ? ? ? ? ? ? ?| ? 10 ++++++++++
> ?arch/arm/mach-exynos4/include/mach/map.h | ? ?5 +++--
> ?arch/arm/plat-s5p/include/plat/map-s5p.h | ? ?5 +++--
> ?3 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
> index 1196f39..6a1ed74 100644
> --- a/arch/arm/mach-exynos4/cpu.c
> +++ b/arch/arm/mach-exynos4/cpu.c
> @@ -107,6 +107,16 @@ static struct map_desc exynos4_iodesc[] __initdata = {
> ? ? ? ? ? ? ? ?.pfn ? ? ? ? ? ?= __phys_to_pfn(EXYNOS4_PA_AUDSS),
> ? ? ? ? ? ? ? ?.length ? ? ? ? = SZ_1K,
> ? ? ? ? ? ? ? ?.type ? ? ? ? ? = MT_DEVICE,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S5P_VA_GIC_CPU,
> + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(EXYNOS4_PA_GIC_CPU),
> + ? ? ? ? ? ? ? .length ? ? ? ? = SZ_64K,
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S5P_VA_GIC_DIST,
> + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(EXYNOS4_PA_GIC_DIST),
> + ? ? ? ? ? ? ? .length ? ? ? ? = SZ_64K,
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
> ? ? ? ?},
> ?};
>
> diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
> index 57d8074..9d5d797 100644
> --- a/arch/arm/mach-exynos4/include/mach/map.h
> +++ b/arch/arm/mach-exynos4/include/mach/map.h
> @@ -61,10 +61,11 @@
>
> ?#define EXYNOS4_PA_COMBINER ? ? ? ? ? ?0x10448000

Isn't this 0x10440000 if we are going to use External GIC?

The user manual says it's 0x10440000 for Ext-GIC and 0x10448000 for
Internal-GIC.


-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
