From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 02:32:13 -0700
Subject: [PATCH v2 30/31] arm64: Build infrastructure
In-Reply-To: <1344966752-16102-31-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-31-git-send-email-catalin.marinas@arm.com>
Message-ID: <20120817093213.GT11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [120814 11:00]:
> --- /dev/null
> +++ b/arch/arm64/Kconfig
> @@ -0,0 +1,261 @@
> +config ARM64
> +	def_bool y
> +	select OF
> +	select OF_EARLY_FLATTREE
> +	select IRQ_DOMAIN
> +	select HAVE_AOUT
> +	select HAVE_DMA_ATTRS
> +	select HAVE_DMA_API_DEBUG
> +	select HAVE_IDE
> +	select HAVE_MEMBLOCK
> +	select RTC_LIB
> +	select SYS_SUPPORTS_APM_EMULATION
> +	select HAVE_GENERIC_DMA_COHERENT
> +	select GENERIC_IOMAP
> +	select HAVE_IRQ_WORK
> +	select HAVE_PERF_EVENTS
> +	select HAVE_ARCH_TRACEHOOK
> +	select PERF_USE_VMALLOC
> +	select HAVE_HW_BREAKPOINT if PERF_EVENTS
> +	select HAVE_GENERIC_HARDIRQS
> +	select GENERIC_HARDIRQS_NO_DEPRECATED
> +	select HAVE_SPARSE_IRQ
> +	select SPARSE_IRQ
> +	select GENERIC_IRQ_SHOW
> +	select GENERIC_SMP_IDLE_THREAD
> +	select NO_BOOTMEM
> +	help
> +	  ARM 64-bit (AArch64) Linux support.

Anything we should select here for ARM generic timers and
interrupts assuming we can always expect to boot using those?

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
