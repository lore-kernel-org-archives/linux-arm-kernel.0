From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Sat, 12 Sep 2009 17:36:55 +0400
Subject: [PATCH v2 RESEND 1/2] ARM: Introduce ARM_L1_CACHE_SHIFT to define
	cache line size
In-Reply-To: <a9bd121a726831bc30f4ec04235eda667e602615.1252770642.git.kirill@shutemov.name>
References: <1252771155-5828-1-git-send-email-kirill@shutemov.name>
	<a9bd121a726831bc30f4ec04235eda667e602615.1252770642.git.kirill@shutemov.name>
Message-ID: <4AABA3F7.2050301@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Kirill A. Shutemov wrote:

> Currently kernel believes that all ARM CPUs have L1_CACHE_SHIFT == 5.
> It's not true at least for CPUs based on Cortex-A8.
>
> List of CPUs with cache line size != 32 should be expanded later.
>
> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
> ---
>  arch/arm/include/asm/cache.h |    2 +-
>  arch/arm/mm/Kconfig          |    5 +++++
>  2 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/include/asm/cache.h b/arch/arm/include/asm/cache.h
> index feaa75f..2ee7743 100644
> --- a/arch/arm/include/asm/cache.h
> +++ b/arch/arm/include/asm/cache.h
> @@ -4,7 +4,7 @@
>  #ifndef __ASMARM_CACHE_H
>  #define __ASMARM_CACHE_H
>  
> -#define L1_CACHE_SHIFT		5
> +#define L1_CACHE_SHIFT		(CONFIG_ARM_L1_CACHE_SHIFT)
>   

   Parens not needed.

WBR, Sergei
