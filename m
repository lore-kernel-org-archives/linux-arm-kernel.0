From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 26 Jan 2015 17:32:33 +0000
Subject: [PATCH 1/5] compat: Declare compat_sys_sigpending and
 compat_sys_sigprocmask prototypes
In-Reply-To: <1420819048-3515-2-git-send-email-catalin.marinas@arm.com>
References: <1420819048-3515-1-git-send-email-catalin.marinas@arm.com>
 <1420819048-3515-2-git-send-email-catalin.marinas@arm.com>
Message-ID: <20150126173233.GE14048@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 03:57:24PM +0000, Catalin Marinas wrote:
> __ARCH_WANT_SYS_SIGPENDING or __ARCH_WANT_SYS_SIGPROGMASK may be defined
> for compat support but the corresponding prototypes are missing from
> linux/compat.h.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Same with this patch, trivial addition of two prototypes.

Thanks.

>  include/linux/compat.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 7450ca2ac1fc..ab25814690bc 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -689,6 +689,15 @@ asmlinkage long compat_sys_sendfile64(int out_fd, int in_fd,
>  asmlinkage long compat_sys_sigaltstack(const compat_stack_t __user *uss_ptr,
>  				       compat_stack_t __user *uoss_ptr);
>  
> +#ifdef __ARCH_WANT_SYS_SIGPENDING
> +asmlinkage long compat_sys_sigpending(compat_old_sigset_t __user *set);
> +#endif
> +
> +#ifdef __ARCH_WANT_SYS_SIGPROCMASK
> +asmlinkage long compat_sys_sigprocmask(int how, compat_old_sigset_t __user *nset,
> +				       compat_old_sigset_t __user *oset);
> +#endif
> +
>  int compat_restore_altstack(const compat_stack_t __user *uss);
>  int __compat_save_altstack(compat_stack_t __user *, unsigned long);
>  #define compat_save_altstack_ex(uss, sp) do { \
