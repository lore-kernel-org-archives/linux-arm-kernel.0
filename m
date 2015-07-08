From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Jul 2015 12:06:51 +0100
Subject: [PATCH V3 2/5] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
In-Reply-To: <1436288623-13007-3-git-send-email-emunson@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
 <1436288623-13007-3-git-send-email-emunson@akamai.com>
Message-ID: <20150708110651.GC6944@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 01:03:40PM -0400, Eric B Munson wrote:
> diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
> index 05745eb..514e77b 100644
> --- a/arch/arm/kernel/calls.S
> +++ b/arch/arm/kernel/calls.S
> @@ -397,6 +397,9 @@
>  /* 385 */	CALL(sys_memfd_create)
>  		CALL(sys_bpf)
>  		CALL(sys_execveat)
> +		CALL(sys_mlock2)
> +		CALL(sys_munlock2)
> +/* 400 */	CALL(sys_munlockall2)

s/400/390/

> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index cef934a..318072aa 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -797,3 +797,9 @@ __SYSCALL(__NR_memfd_create, sys_memfd_create)
>  __SYSCALL(__NR_bpf, sys_bpf)
>  #define __NR_execveat 387
>  __SYSCALL(__NR_execveat, compat_sys_execveat)
> +#define __NR_mlock2 388
> +__SYSCALL(__NR_mlock2, sys_mlock2)
> +#define __NR_munlock2 389
> +__SYSCALL(__NR_munlock2, sys_munlock2)
> +#define __NR_munlockall2 390
> +__SYSCALL(__NR_munlockall2, sys_munlockall2)

These look fine.

Catalin
