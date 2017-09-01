From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 1 Sep 2017 11:35:00 +0100
Subject: [PATCH] ARM: entry: Remove dead code in sys_mmap2
In-Reply-To: <1502700269-24384-2-git-send-email-vladimir.murzin@arm.com>
References: <1502700269-24384-1-git-send-email-vladimir.murzin@arm.com>
 <1502700269-24384-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <76c18ba8-081f-f842-8dd3-2d6fbffc2e26@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/17 09:44, Vladimir Murzin wrote:
> We support page size of 4K only, remove dead code.
>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/kernel/entry-common.S | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index eb5cd77..52237ce 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -371,17 +371,8 @@ ENDPROC(sys_fstatfs64_wrapper)
>   * offset, we return EINVAL.
>   */
>  sys_mmap2:
> -#if PAGE_SHIFT > 12
> -             tst     r5, #PGOFF_MASK
> -             moveq   r5, r5, lsr #PAGE_SHIFT - 12
> -             streq   r5, [sp, #4]
> -             beq     sys_mmap_pgoff
> -             mov     r0, #-EINVAL
> -             ret     lr
> -#else
>               str     r5, [sp, #4]
>               b       sys_mmap_pgoff
> -#endif
>  ENDPROC(sys_mmap2)
>
>  #ifdef CONFIG_OABI_COMPAT
>

Ok for patch tracker?

Vladimir
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
