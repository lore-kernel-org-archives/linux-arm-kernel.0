From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 16 Jul 2014 16:37:48 -0700
Subject: [PATCH v2 1/3] ACPI: ARM64 does not have a BIOS add config for
 BIOS table scan.
In-Reply-To: <1404898746-6685-2-git-send-email-hanjun.guo@linaro.org>
References: <1404898746-6685-1-git-send-email-hanjun.guo@linaro.org>
 <1404898746-6685-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <53C70CCC.2080109@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2014 02:39 AM, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> With the addition of ARM64 that does not have a traditional BIOS to
> scan, add a config option which is selected on x86 and ia64 to do
> the traditional BIOS scanning for tables.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/ia64/Kconfig    |    1 +
>  arch/x86/Kconfig     |    1 +
>  drivers/acpi/Kconfig |    3 +++
>  drivers/acpi/osl.c   |    4 +++-
>  4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 2f3abcf..c54bd7e 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -47,6 +47,7 @@ config IA64
>  	select MODULES_USE_ELF_RELA
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select HAVE_ARCH_AUDITSYSCALL
> +	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
>  	default y
>  	help
>  	  The Itanium Processor Family is Intel's 64-bit successor to

This shouldn't actually be set on IA64, should it?  IA64 doesn't have
BIOS, either, it has EFI/UEFI, like ARM64...

	-hpa
