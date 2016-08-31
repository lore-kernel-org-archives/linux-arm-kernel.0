From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 31 Aug 2016 20:47:35 +0800
Subject: [PATCH] arm64: cleanup unused UDBG_* define
In-Reply-To: <1472647130-61050-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1472647130-61050-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <0edea4d7-e335-9f83-3277-68f6ad608d05@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ arm maillist

On 2016/8/31 20:38, Kefeng Wang wrote:
> The UDBG_UNDEFINED/SYSCALL/BADABORT/SEGV are only used to show
> verbose user fault messages in arm, not arm64, drop them.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/include/asm/system_misc.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
> index 57f110b..bc81243 100644
> --- a/arch/arm64/include/asm/system_misc.h
> +++ b/arch/arm64/include/asm/system_misc.h
> @@ -56,12 +56,6 @@ extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>  	__show_ratelimited;						\
>  })
>  
> -#define UDBG_UNDEFINED	(1 << 0)
> -#define UDBG_SYSCALL	(1 << 1)
> -#define UDBG_BADABORT	(1 << 2)
> -#define UDBG_SEGV	(1 << 3)
> -#define UDBG_BUS	(1 << 4)
> -
>  #endif	/* __ASSEMBLY__ */
>  
>  #endif	/* __ASM_SYSTEM_MISC_H */
> 
