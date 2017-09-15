From: james.morse@arm.com (James Morse)
Date: Fri, 15 Sep 2017 19:35:43 +0100
Subject: [PATCH] arm64: Unconditionally support ARCH_HAVE_NMI_SAFE_CMPXCHG
In-Reply-To: <20170915011915.7993-1-sboyd@codeaurora.org>
References: <20170915011915.7993-1-sboyd@codeaurora.org>
Message-ID: <59BC1D7F.4090107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 15/09/17 02:19, Stephen Boyd wrote:
> From what I can see there isn't anything about ACPI_APEI_SEA that
> means the arm64 architecture can or cannot support NMI safe
> cmpxchg, so the if condition here is not important. 

Yup, it was to match 'HAVE_NMI', which was new with ACPI_APEI_SEA and pulls in
some printk() stuff.

... how come you don't need to change HAVE_NMI too?


> Let's remove
> it. Doing that allows us to support ftrace histograms via
> CONFIG_HIST_TRIGGERS that depends on the arch having this config
> selected.

What does CONFIG_HIST_TRIGGERS need this for? I can't see any
cmpxchg use in kernel/trace/trace_events_hist.c


Regardless,

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0df64a6a56d4..27ce2ab7b080 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -21,7 +21,7 @@ config ARM64
>  	select ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_HAS_STRICT_MODULE_RWX
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> -	select ARCH_HAVE_NMI_SAFE_CMPXCHG if ACPI_APEI_SEA
> +	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select ARCH_SUPPORTS_MEMORY_FAILURE
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> 
