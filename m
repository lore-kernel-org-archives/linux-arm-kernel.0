From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Sep 2016 14:55:34 +0200
Subject: [PATCH 12/18] arm64: ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <57C9587B.9080006@huawei.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
 <1471434403-25291-13-git-send-email-ynorov@caviumnetworks.com>
 <57C9587B.9080006@huawei.com>
Message-ID: <6815916.BISHOLF1Ut@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 2, 2016 6:46:19 PM CEST Bamvor Jian Zhang wrote:
> diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
> index 043d17a..78bea1d 100644
> --- a/arch/arm64/include/uapi/asm/unistd.h
> +++ b/arch/arm64/include/uapi/asm/unistd.h
> @@ -16,4 +16,9 @@
> 
>  #define __ARCH_WANT_RENAMEAT
> 
> +/* We need to make sure it works for both userspace and kernel(sys_ilp32.c) */
> +#if defined(__ILP32__) || defined(__SYSCALL_COMPAT)
> +#define __ARCH_WANT_SYNC_FILE_RANGE2
> +#endif
> +
>  #include <asm-generic/unistd.h>
> diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
> index 10fc0ca..13c9c9d 100644
> --- a/arch/arm64/kernel/sys_ilp32.c
> +++ b/arch/arm64/kernel/sys_ilp32.c
> @@ -42,7 +42,7 @@
>  #define compat_sys_pwrite64            compat_sys_pwrite64_wrapper
>  #define compat_sys_readahead           compat_sys_readahead_wrapper
>  #define compat_sys_shmat               sys_shmat
> -#define compat_sys_sync_file_range     compat_sys_sync_file_range2_wrapper
> +#define compat_sys_sync_file_range2    compat_sys_sync_file_range2_wrapper
>  #define compat_sys_truncate64          compat_sys_truncate64_wrapper
>  #define sys_mmap2                      compat_sys_mmap2_wrapper
>  #define sys_ptrace                     compat_sys_ptrace
> 

Looks good to me.

	Arnd
