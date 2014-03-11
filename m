From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 11 Mar 2014 20:57:29 +0200
Subject: [PATCH] ARM: unistd.h: relocate comments back to place
In-Reply-To: <98efb0a6377be2ae7d92eab50ed30f6258e8a28d.1391455314.git.baruch@tkos.co.il>
References: <98efb0a6377be2ae7d92eab50ed30f6258e8a28d.1391455314.git.baruch@tkos.co.il>
Message-ID: <20140311185729.GY4249@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Feb 03, 2014 at 09:21:54PM +0200, Baruch Siach wrote:
> Commit cb8db5d45 (UAPI: (Scripted) Disintegrate arch/arm/include/asm) moved
> these syscall comments out of their context into the UAPI headers. Fix this.
> 
> Fixes: cb8db5d4578a ("UAPI: (Scripted) Disintegrate arch/arm/include/asm")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---

Is this patch OK for the patch system? It seems trivially correct.

baruch

>  arch/arm/include/asm/unistd.h      | 10 ++++++++++
>  arch/arm/include/uapi/asm/unistd.h | 11 -----------
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
> index acabef1a75df..4229595e5c04 100644
> --- a/arch/arm/include/asm/unistd.h
> +++ b/arch/arm/include/asm/unistd.h
> @@ -15,7 +15,17 @@
>  
>  #include <uapi/asm/unistd.h>
>  
> +/*
> + * This may need to be greater than __NR_last_syscall+1 in order to
> + * account for the padding in the syscall table
> + */
>  #define __NR_syscalls  (384)
> +
> +/*
> + * *NOTE*: This is a ghost syscall private to the kernel.  Only the
> + * __kuser_cmpxchg code in entry-armv.S should be aware of its
> + * existence.  Don't ever use this from user code.
> + */
>  #define __ARM_NR_cmpxchg		(__ARM_NR_BASE+0x00fff0)
>  
>  #define __ARCH_WANT_STAT64
> diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
> index fb5584d0cc05..c3776331f407 100644
> --- a/arch/arm/include/uapi/asm/unistd.h
> +++ b/arch/arm/include/uapi/asm/unistd.h
> @@ -410,11 +410,6 @@
>  #define __NR_sched_getattr		(__NR_SYSCALL_BASE+381)
>  
>  /*
> - * This may need to be greater than __NR_last_syscall+1 in order to
> - * account for the padding in the syscall table
> - */
> -
> -/*
>   * The following SWIs are ARM private.
>   */
>  #define __ARM_NR_BASE			(__NR_SYSCALL_BASE+0x0f0000)
> @@ -425,12 +420,6 @@
>  #define __ARM_NR_set_tls		(__ARM_NR_BASE+5)
>  
>  /*
> - * *NOTE*: This is a ghost syscall private to the kernel.  Only the
> - * __kuser_cmpxchg code in entry-armv.S should be aware of its
> - * existence.  Don't ever use this from user code.
> - */
> -
> -/*
>   * The following syscalls are obsolete and no longer available for EABI.
>   */
>  #if !defined(__KERNEL__)
> -- 
> 1.8.5.3

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
