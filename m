From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 21 Sep 2011 15:25:17 +0900
Subject: [RESEND PATCH 2/3] ARM: EXYNOS4: Update consistent DMA size to 8MB
In-Reply-To: <1316583860-32510-3-git-send-email-hatim.rv@samsung.com>
References: <1316583860-32510-1-git-send-email-hatim.rv@samsung.com>
	<1316583860-32510-3-git-send-email-hatim.rv@samsung.com>
Message-ID: <CAH9JG2XegdW95MvFcstfrWOWsqQjJob9kiTwFq8tnZn_SbS+bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As I know,  CONSISTENT_DMA_SIZE is removed, please use the updated APIs.

Thank you,
Kyungmin Park

On Wed, Sep 21, 2011 at 2:44 PM, Hatim Ali <hatim.rv@samsung.com> wrote:
> Change the consistent DMA allocation to 8MB to support the
> TVOUT driver.
>
> NOTE: Once CMA support is merged into mainline, we will use it for memory
> allocation.
>
> Signed-off-by: Hatim Ali <hatim.rv@samsung.com>
> ---
> ?arch/arm/mach-exynos4/include/mach/memory.h | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/include/mach/memory.h b/arch/arm/mach-exynos4/include/mach/memory.h
> index 374ef2c..7549742 100644
> --- a/arch/arm/mach-exynos4/include/mach/memory.h
> +++ b/arch/arm/mach-exynos4/include/mach/memory.h
> @@ -15,6 +15,8 @@
>
> ?#define PLAT_PHYS_OFFSET ? ? ? ? ? ? ? UL(0x40000000)
>
> +#define CONSISTENT_DMA_SIZE ? ? ? ? ? ?SZ_8M
> +
> ?/* Maximum of 256MiB in one bank */
> ?#define MAX_PHYSMEM_BITS ? ? ? 32
> ?#define SECTION_SIZE_BITS ? ? ?28
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
