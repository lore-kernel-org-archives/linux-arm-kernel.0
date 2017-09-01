From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 1 Sep 2017 11:35:16 +0100
Subject: [PATCH] ARM: mm: Remove dead code in mem_init()
In-Reply-To: <1502700269-24384-3-git-send-email-vladimir.murzin@arm.com>
References: <1502700269-24384-1-git-send-email-vladimir.murzin@arm.com>
 <1502700269-24384-3-git-send-email-vladimir.murzin@arm.com>
Message-ID: <f6a6b57d-b847-8ee6-90bc-771187c7c776@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/17 09:44, Vladimir Murzin wrote:
> The code in question checks memory constrains to set default policy for
> overcommit; however we support page size of 4K only thus condition is
> always evaluated to false. Remove that dead code.
>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/mm/init.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index ad80548..81d4482 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -580,16 +580,6 @@ void __init mem_init(void)
>       BUILD_BUG_ON(PKMAP_BASE + LAST_PKMAP * PAGE_SIZE > PAGE_OFFSET);
>       BUG_ON(PKMAP_BASE + LAST_PKMAP * PAGE_SIZE      > PAGE_OFFSET);
>  #endif
> -
> -     if (PAGE_SIZE >= 16384 && get_num_physpages() <= 128) {
> -             extern int sysctl_overcommit_memory;
> -             /*
> -              * On a machine this small we won't get
> -              * anywhere without overcommit, so turn
> -              * it on by default.
> -              */
> -             sysctl_overcommit_memory = OVERCOMMIT_ALWAYS;
> -     }
>  }
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
>

Ok for patch tracker?

Vladimir
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
