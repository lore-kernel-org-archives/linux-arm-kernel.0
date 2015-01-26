From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 26 Jan 2015 13:48:03 -0800
Subject: [PATCH 1/5] compat: Declare compat_sys_sigpending and
 compat_sys_sigprocmask prototypes
In-Reply-To: <1420819048-3515-2-git-send-email-catalin.marinas@arm.com>
References: <1420819048-3515-1-git-send-email-catalin.marinas@arm.com>
 <1420819048-3515-2-git-send-email-catalin.marinas@arm.com>
Message-ID: <20150126134803.99158a48850283da3d67d6cf@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  9 Jan 2015 15:57:24 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:

> __ARCH_WANT_SYS_SIGPENDING or __ARCH_WANT_SYS_SIGPROGMASK may be defined
> for compat support but the corresponding prototypes are missing from
> linux/compat.h.
> 
> ...
>
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

ack, please merge and submit.
