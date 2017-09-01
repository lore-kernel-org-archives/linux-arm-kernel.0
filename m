From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 1 Sep 2017 11:34:23 +0100
Subject: [PATCH] ARM: Remove leftover of fixmap_page_table
In-Reply-To: <1502700269-24384-1-git-send-email-vladimir.murzin@arm.com>
References: <1502700269-24384-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <0a7e5d42-de9a-6424-7976-e2240da182de@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/17 09:44, Vladimir Murzin wrote:
> fixmap_page_table was removed by commit 836a24183273 (ARM: expand
> fixmap region to 3MB), but some traces are still there - get rid of
> them.
>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/include/asm/highmem.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
> index 0a0e2d1..61736fd 100644
> --- a/arch/arm/include/asm/highmem.h
> +++ b/arch/arm/include/asm/highmem.h
> @@ -18,7 +18,6 @@
>       } while (0)
>
>  extern pte_t *pkmap_page_table;
> -extern pte_t *fixmap_page_table;
>
>  extern void *kmap_high(struct page *page);
>  extern void kunmap_high(struct page *page);
>

Ok for patch tracker?

Vladimir
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
