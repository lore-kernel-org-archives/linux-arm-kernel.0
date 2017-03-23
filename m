From: james.morse@arm.com (James Morse)
Date: Thu, 23 Mar 2017 14:33:05 +0000
Subject: [PATCH] arm64: kconfig: allow support for memory failure handling
In-Reply-To: <1485985115-27274-1-git-send-email-tbaicar@codeaurora.org>
References: <1485985115-27274-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <58D3DCA1.5090006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

On 01/02/17 21:38, Tyler Baicar wrote:
> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
> 
> If ACPI_APEI and MEMORY_FAILURE is configured, select
> ACPI_APEI_MEMORY_FAILURE. This enables memory failure recovery
> when such memory failure is reported through ACPI APEI. APEI
> (ACPI Platform Error Interfaces) provides a means for the
> platform to convey error information to the kernel.
> 
> Declare ARCH_SUPPORTS_MEMORY_FAILURE, as arm64 does support
> memory failure recovery attempt.

Am I right in thinking we should wait for the hugepage issue you found with
hwpoison [0] to be fixed before arm64 can have ARCH_SUPPORTS_MEMORY_FAILURE?

(If so, can this patch become part of that series to they are obviously related!)

Thanks,

James

[0] https://www.spinics.net/lists/arm-kernel/msg568995.html




> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f92778d..4cd12a0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -15,6 +15,8 @@ config ARM64
>  	select ARCH_HAS_SG_CHAIN
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_USE_CMPXCHG_LOCKREF
> +	select ACPI_APEI_MEMORY_FAILURE if ACPI_APEI && MEMORY_FAILURE
> +	select ARCH_SUPPORTS_MEMORY_FAILURE
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
> 
