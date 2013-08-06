From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 6 Aug 2013 14:19:42 +0100
Subject: [PATCH 4/7] Add proper definitions for some EFI function pointers.
In-Reply-To: <1375478948-22562-5-git-send-email-roy.franz@linaro.org>
References: <1375478948-22562-1-git-send-email-roy.franz@linaro.org>
 <1375478948-22562-5-git-send-email-roy.franz@linaro.org>
Message-ID: <20130806131942.GW2515@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 02 Aug, at 02:29:05PM, Roy Franz wrote:
> The x86/AMD64 EFI stubs must us a call wrapper to convert between
> the Linux and EFI ABIs, so void pointers are sufficient.  For ARM,
> the ABIs are compatible, so we can directly invoke the function
> pointers.  The functions that are used by the ARM stub are updated
> to match the EFI definitions.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---
>  include/linux/efi.h |   61 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 17 deletions(-)

[...]

> @@ -96,6 +98,26 @@ typedef	struct {
>  #define EFI_MEMORY_DESCRIPTOR_VERSION	1
>  
>  #define EFI_PAGE_SHIFT		12
> +#define EFI_PAGE_SIZE		(1UL << EFI_PAGE_SHIFT)
> +
> +typedef enum {
> +	EfiReservedMemoryType,
> +	EfiLoaderCode,
> +	EfiLoaderData,
> +	EfiBootServicesCode,
> +	EfiBootServicesData,
> +	EfiRuntimeServicesCode,
> +	EfiRuntimeServicesData,
> +	EfiConventionalMemory,
> +	EfiUnusableMemory,
> +	EfiACPIReclaimMemory,
> +	EfiACPIMemoryNVS,
> +	EfiMemoryMappedIO,
> +	EfiMemoryMappedIOPortSpace,
> +	EfiPalCode,
> +	EfiMaxMemoryType
> +} EFI_MEMORY_TYPE;
> +

These enums aren't used anywhere in your patches from what I can see and
we already have #define's for all these values, e.g. EFI_RESERVED_TYPE.

-- 
Matt Fleming, Intel Open Source Technology Center
