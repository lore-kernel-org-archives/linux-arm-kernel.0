From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jul 2018 18:53:38 +0100
Subject: [PATCH v2 2/3] asm-generic: unistd.h: Wire up sys_rseq
In-Reply-To: <1531145985-3747-3-git-send-email-will.deacon@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
 <1531145985-3747-3-git-send-email-will.deacon@arm.com>
Message-ID: <20180710175337.GD10177@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Jul 09, 2018 at 03:19:44PM +0100, Will Deacon wrote:
> The new rseq call arrived in 4.18-rc1, so provide it in the asm-generic
> unistd.h for architectures such as arm64.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  include/uapi/asm-generic/unistd.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Please can you Ack this, so I can take it the arm64 tree?

Thanks,

Will

> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 42990676a55e..df4bedb9b01c 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
>  __SYSCALL(__NR_statx,     sys_statx)
>  #define __NR_io_pgetevents 292
>  __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
> +#define __NR_rseq 293
> +__SYSCALL(__NR_rseq, sys_rseq)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 293
> +#define __NR_syscalls 294
>  
>  /*
>   * 32 bit systems traditionally used different
> -- 
> 2.1.4
> 
