From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 13 Jun 2017 08:37:20 +0100
Subject: [PATCH 1/2] arm: nommu: remove unused KTHREAD_SIZE definition
In-Reply-To: <20170612170937.2969-1-jeremy.lefaure@lse.epita.fr>
References: <20170612170937.2969-1-jeremy.lefaure@lse.epita.fr>
Message-ID: <331b6524-acd6-37ec-df72-9b8b2f3eec97@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/17 18:09, J?r?my Lefaure wrote:
> I didn't find any use of this macro in the current kernel tree (with git
> grep). KTHREAD_SIZE is no longer used for a very very long time. So
> let's remove this definition.
> 
> Signed-off-by: J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>
> ---
>  arch/arm/include/asm/page-nommu.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/page-nommu.h b/arch/arm/include/asm/page-nommu.h
> index 503f488053de..8f2c47bec375 100644
> --- a/arch/arm/include/asm/page-nommu.h
> +++ b/arch/arm/include/asm/page-nommu.h
> @@ -11,12 +11,6 @@
>  #ifndef _ASMARM_PAGE_NOMMU_H
>  #define _ASMARM_PAGE_NOMMU_H
>  
> -#if !defined(CONFIG_SMALL_TASKS) && PAGE_SHIFT < 13
> -#define KTHREAD_SIZE (8192)
> -#else
> -#define KTHREAD_SIZE PAGE_SIZE
> -#endif
> - 
>  #define clear_page(page)	memset((page), 0, PAGE_SIZE)
>  #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
>  
> 

Even more, CONFIG_SMALL_TASKS has gone and only page size we support is 4K.

It looks like that similar patch has been submitted several times by different
people but never got merged, so if it helps:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir
