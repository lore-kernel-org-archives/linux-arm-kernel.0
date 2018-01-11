From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Fri, 12 Jan 2018 00:59:57 +0300
Subject: [PATCH 2/2] kasan: clean up KASAN_SHADOW_SCALE_SHIFT usage
In-Reply-To: <ff221eca3db7a1f208c30c625b7d209fba33abb9.1515684162.git.andreyknvl@google.com>
References: <cover.1515684162.git.andreyknvl@google.com>
 <ff221eca3db7a1f208c30c625b7d209fba33abb9.1515684162.git.andreyknvl@google.com>
Message-ID: <c8f1d954-64fe-1e9c-d8ba-94e880de2501@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/11/2018 06:29 PM, Andrey Konovalov wrote:

> diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
> index e266f80e45b7..811643fe7640 100644
> --- a/arch/arm64/include/asm/kasan.h
> +++ b/arch/arm64/include/asm/kasan.h
> @@ -27,7 +27,8 @@
>   * should satisfy the following equation:
>   *      KASAN_SHADOW_OFFSET = KASAN_SHADOW_END - (1ULL << 61)

Care to update comments as well?

>   */
> -#define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << (64 - 3)))
> +#define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << \
> +					(64 - KASAN_SHADOW_SCALE_SHIFT)))
>  
>  void kasan_init(void);
>  void kasan_copy_shadow(pgd_t *pgdir);
