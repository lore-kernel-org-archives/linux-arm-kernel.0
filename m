From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 03 Nov 2010 22:42:08 -0400 (EDT)
Subject: [PATCH 3/3] ARM: atomic64: use generic implementation for OABI
	configurations
In-Reply-To: <1288804947-21213-4-git-send-email-will.deacon@arm.com>
References: <1288804947-21213-1-git-send-email-will.deacon@arm.com>
	<1288804947-21213-4-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.00.1011032241440.18581@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Nov 2010, Will Deacon wrote:

> The old apcs-gnu ABI doesn't guarantee that double words are allocated
> to registers with even alignment, causing the 64-bit exclusive memory
> operations to be rejected by the assembler.
> 
> This patch requires that CONFIG_AEABI is set in order to use the native
> atomic operations and falls back to the generic (spinlock) code otherwise.
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>



> ---
>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a19a526..8ae3d48 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -6,7 +6,7 @@ config ARM
>  	select HAVE_MEMBLOCK
>  	select RTC_LIB
>  	select SYS_SUPPORTS_APM_EMULATION
> -	select GENERIC_ATOMIC64 if (!CPU_32v6K)
> +	select GENERIC_ATOMIC64 if (!CPU_32v6K || !AEABI)
>  	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
>  	select HAVE_ARCH_KGDB
>  	select HAVE_KPROBES if (!XIP_KERNEL)
> -- 
> 1.7.0.4
> 
