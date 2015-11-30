From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 30 Nov 2015 15:44:13 +0000
Subject: [Xen-devel] [PATCH v3 62/62] xen/arm64: Add ACPI support
In-Reply-To: <1447753261-7552-63-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-63-git-send-email-shannon.zhao@linaro.org>
Message-ID: <565C6ECD.2040702@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 17/11/15 09:41, shannon.zhao at linaro.org wrote:
> From: Naresh Bhat <naresh.bhat@linaro.org>
> 
> Add ACPI support on arm64 xen hypervisor. Enable EFI support on ARM.
> 
> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  config/arm64.mk              | 1 +
>  xen/common/efi/runtime.c     | 2 +-
>  xen/include/asm-arm/config.h | 5 +++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/config/arm64.mk b/config/arm64.mk
> index c5deb4e..c6a040b 100644
> --- a/config/arm64.mk
> +++ b/config/arm64.mk
> @@ -11,6 +11,7 @@ HAS_CADENCE_UART := y
>  HAS_NS16550 := y
>  HAS_MEM_ACCESS := y
>  HAS_GICV3 := y
> +HAS_ACPI := y
>  
>  # Use only if calling $(LD) directly.
>  LDFLAGS_DIRECT += -EL
> diff --git a/xen/common/efi/runtime.c b/xen/common/efi/runtime.c
> index ae87557..7748056 100644
> --- a/xen/common/efi/runtime.c
> +++ b/xen/common/efi/runtime.c
> @@ -11,7 +11,7 @@ DEFINE_XEN_GUEST_HANDLE(CHAR16);
>  #ifndef COMPAT
>  
>  #ifdef CONFIG_ARM  /* Disabled until runtime services implemented */
> -const bool_t efi_enabled = 0;
> +const bool_t efi_enabled = 1;

Can you explained why efi_enabled is set unconditionally? Xen may have
boot without EFI.

Regards,

-- 
Julien Grall
