From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 7 Aug 2013 14:09:50 +0100
Subject: [PATCH 12/17] Add proper definitions for some EFI function
 pointers.
In-Reply-To: <1375847113-24884-13-git-send-email-roy.franz@linaro.org>
References: <1375847113-24884-1-git-send-email-roy.franz@linaro.org>
 <1375847113-24884-13-git-send-email-roy.franz@linaro.org>
Message-ID: <20130807130950.GF2515@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Aug, at 08:45:08PM, Roy Franz wrote:
> The x86/AMD64 EFI stubs must us a call wrapper to convert between
> the Linux and EFI ABIs, so void pointers are sufficient.  For ARM,
> the ABIs are compatible, so we can directly invoke the function
> pointers.  The functions that are used by the ARM stub are updated
> to match the EFI definitions.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---
>  include/linux/efi.h |   42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 51f5641..96bb866 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -39,6 +39,8 @@
>  typedef unsigned long efi_status_t;
>  typedef u8 efi_bool_t;
>  typedef u16 efi_char16_t;		/* UNICODE character */
> +typedef u64 efi_physical_addr_t;
> +typedef void *efi_handle_t;
>  
>  
>  typedef struct {
> @@ -96,6 +98,7 @@ typedef	struct {
>  #define EFI_MEMORY_DESCRIPTOR_VERSION	1
>  
>  #define EFI_PAGE_SHIFT		12
> +#define EFI_PAGE_SIZE		(1UL << EFI_PAGE_SHIFT)

It would be worth getting rid of the EFI_PAGE_SIZE definition in
arch/x86/boot/compressed/eboot.h now that we have one here.

-- 
Matt Fleming, Intel Open Source Technology Center
