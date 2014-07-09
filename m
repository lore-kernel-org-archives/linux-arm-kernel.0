From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 9 Jul 2014 14:20:37 +0300
Subject: [PATCH v2] ARM: unistd.h: relocate comments back to place
In-Reply-To: <da87ed3ed4d6ee451306b8cc4c05ce011f1b1935.1400230286.git.baruch@tkos.co.il>
References: <da87ed3ed4d6ee451306b8cc4c05ce011f1b1935.1400230286.git.baruch@tkos.co.il>
Message-ID: <20140709112037.GH3003@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, May 16, 2014 at 11:51:26AM +0300, Baruch Siach wrote:
> Commit cb8db5d45 (UAPI: (Scripted) Disintegrate arch/arm/include/asm) moved
> these syscall comments out of their context into the UAPI headers. Fix this.
> 
> Fixes: cb8db5d4578a ("UAPI: (Scripted) Disintegrate arch/arm/include/asm")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

I take the lack of response as approval. If no one objects I'll send this to 
the patch system later today.

baruch

> ---
> v2:
>    Rebase on v3.15-rc5
> 
> Hi Arnd,
> 
> A previous version of this patch
> (http://thread.gmane.org/gmane.linux.ports.arm.kernel/298234) was ignored. I
> guess Russell is just overloaded. Would you ack this seemingly trivial patch so
> I can put it in Russell's patches tracker?
> 
> baruch
> ---
>  arch/arm/include/asm/unistd.h      | 10 ++++++++++
>  arch/arm/include/uapi/asm/unistd.h | 11 -----------
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
> index 43876245fc57..21ca0cebcab0 100644
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
> index ba94446c72d9..acd5b66ea3aa 100644
> --- a/arch/arm/include/uapi/asm/unistd.h
> +++ b/arch/arm/include/uapi/asm/unistd.h
> @@ -411,11 +411,6 @@
>  #define __NR_renameat2			(__NR_SYSCALL_BASE+382)
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
> @@ -426,12 +421,6 @@
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
> 2.0.0.rc0
> 

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
