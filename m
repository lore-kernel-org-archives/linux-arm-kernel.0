From: dirk.behme@gmail.com (Dirk Behme)
Date: Sun, 09 Feb 2014 07:09:49 +0100
Subject: [PATCH] arm: add DSB after icache flush in __flush_icache_all()
In-Reply-To: <1391592782-18576-1-git-send-email-vkale@apm.com>
References: <1391592782-18576-1-git-send-email-vkale@apm.com>
Message-ID: <52F71BAD.80607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 05.02.2014 10:33, schrieb Vinayak Kale:
> Add DSB after icache flush to complete the cache maintenance operation.
>
> Signed-off-by: Vinayak Kale <vkale@apm.com>

Should this go to -stable, too?

I haven't looked into the details, but at least it seems to apply 
cleanly on a 3.8 kernel.

Best regards

Dirk

> ---
>
> PS:
> - This patch is tested for ARM-v7.
>
>   arch/arm/include/asm/cacheflush.h |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index ee753f1..ab91ebb 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -212,6 +212,7 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
>   static inline void __flush_icache_all(void)
>   {
>   	__flush_icache_preferred();
> +	dsb();
>   }
>
>   /*
>
