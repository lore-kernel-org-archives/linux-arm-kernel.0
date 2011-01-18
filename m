From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Jan 2011 10:24:20 -0000
Subject: [PATCH 09/14] ARM: v6k: select generic atomic64 code according to
	V6	variants
In-Reply-To: <E1PeugN-0003Sp-0J@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeugN-0003Sp-0J@rmk-PC.arm.linux.org.uk>
Message-ID: <000501cbb6f9$deb8b530$9c2a1f90$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If CONFIG_CPU_V6 is enabled, avoid using the double-word exclusive
> instructions in the kernel's atomic implementations as these are not
> supported.  Fall back to the generic spinlock code instead.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 95ba92f..283d7b9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -7,7 +7,7 @@ config ARM
>  	select HAVE_MEMBLOCK
>  	select RTC_LIB
>  	select SYS_SUPPORTS_APM_EMULATION
> -	select GENERIC_ATOMIC64 if (!CPU_32v6K || !AEABI)
> +	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
>  	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
>  	select HAVE_ARCH_KGDB
>  	select HAVE_KPROBES if (!XIP_KERNEL && !THUMB2_KERNEL)

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
