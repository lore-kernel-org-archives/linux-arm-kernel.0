From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 5 May 2010 14:10:19 +0800
Subject: [PATCH 04/10] [ARM] pxa: update cpuid pattern of pxa9xx
In-Reply-To: <x2j771cded01004290117h3687796fs634ce7fdd7974482@mail.gmail.com>
References: <x2j771cded01004290117h3687796fs634ce7fdd7974482@mail.gmail.com>
Message-ID: <s2pf17812d71005042310j4baf4ae1rebcba4b8dda314b6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 4:17 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From c0b403d09f7054617e657bae0ca4dbfc63ddb71f Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Fri, 12 Mar 2010 05:47:55 -0500
> Subject: [PATCH] [ARM] pxa: update cpuid pattern of pxa9xx
>
> Update CPUID pattern of PXA9xx in head.S.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Applied.

> ---
> ?arch/arm/boot/compressed/head.S | ? 10 ++--------
> ?1 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 6ab6b33..c5191b1 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -685,8 +685,8 @@ proc_types:
> ? ? ? ? ? ? ? ?W(b) ? ?__armv4_mmu_cache_off
> ? ? ? ? ? ? ? ?W(b) ? ?__armv4_mmu_cache_flush
>
> - ? ? ? ? ? ? ? .word ? 0x56056930
> - ? ? ? ? ? ? ? .word ? 0xff0ffff0 ? ? ? ? ? ? ?@ PXA935
> + ? ? ? ? ? ? ? .word ? 0x56056900
> + ? ? ? ? ? ? ? .word ? 0xffffff00 ? ? ? ? ? ? ?@ PXA9xx
> ? ? ? ? ? ? ? ?W(b) ? ?__armv4_mmu_cache_on
> ? ? ? ? ? ? ? ?W(b) ? ?__armv4_mmu_cache_off
> ? ? ? ? ? ? ? ?W(b) ? ?__armv4_mmu_cache_flush
> @@ -697,12 +697,6 @@ proc_types:
> ? ? ? ? ? ? ? ?W(b) ? ?__armv4_mmu_cache_off
> ? ? ? ? ? ? ? ?W(b) ? ?__armv5tej_mmu_cache_flush
>
> - ? ? ? ? ? ? ? .word ? 0x56056930
> - ? ? ? ? ? ? ? .word ? 0xff0ffff0 ? ? ? ? ? ? ?@ PXA935
> - ? ? ? ? ? ? ? W(b) ? ?__armv4_mmu_cache_on
> - ? ? ? ? ? ? ? W(b) ? ?__armv4_mmu_cache_off
> - ? ? ? ? ? ? ? W(b) ? ?__armv4_mmu_cache_flush
> -
> ? ? ? ? ? ? ? ?.word ? 0x56050000 ? ? ? ? ? ? ?@ Feroceon
> ? ? ? ? ? ? ? ?.word ? 0xff0f0000
> ? ? ? ? ? ? ? ?W(b) ? ?__armv4_mmu_cache_on
> --
> 1.5.6.5
>
