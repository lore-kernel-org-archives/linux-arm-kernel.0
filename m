From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 22 Feb 2017 01:53:54 +0100
Subject: [PATCH V2] arm64: kconfig: allow support for memory failure
 handling
In-Reply-To: <1487720723-14871-1-git-send-email-tbaicar@codeaurora.org>
References: <1487720723-14871-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <4367727.rNzyOA836A@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+ Boris]

On Tuesday, February 21, 2017 04:45:23 PM Tyler Baicar wrote:
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
> 
> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  arch/arm64/Kconfig        | 1 +
>  drivers/acpi/apei/Kconfig | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1117421..61e0bb0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -15,6 +15,7 @@ config ARM64
>  	select ARCH_HAS_SG_CHAIN
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_USE_CMPXCHG_LOCKREF
> +	select ARCH_SUPPORTS_MEMORY_FAILURE
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index b0140c8..6d9a812 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -9,6 +9,7 @@ config ACPI_APEI
>  	select MISC_FILESYSTEMS
>  	select PSTORE
>  	select UEFI_CPER
> +	select ACPI_APEI_MEMORY_FAILURE if MEMORY_FAILURE
>  	depends on HAVE_ACPI_APEI
>  	help
>  	  APEI allows to report errors (for example from the chipset)
> 
