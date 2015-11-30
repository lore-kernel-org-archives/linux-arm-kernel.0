From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 30 Nov 2015 14:57:53 +0000
Subject: [Xen-devel] [PATCH v3 20/62] arm/acpi: Add ACPI support for SMP
 initialization
In-Reply-To: <1447753261-7552-21-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-21-git-send-email-shannon.zhao@linaro.org>
Message-ID: <565C63F1.5070303@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> diff --git a/xen/arch/arm/psci.c b/xen/arch/arm/psci.c
> index d800cb6..dede0e1 100644
> --- a/xen/arch/arm/psci.c
> +++ b/xen/arch/arm/psci.c
> @@ -22,6 +22,7 @@
>  #include <xen/mm.h>
>  #include <xen/smp.h>
>  #include <asm/psci.h>
> +#include <asm/acpi.h>
>  
>  /*
>   * While a 64-bit OS can make calls with SMC32 calling conventions, for
> @@ -86,6 +87,9 @@ int __init psci_init_0_1(void)
>      int ret;
>      const struct dt_device_node *psci;
>  
> +    if ( !acpi_disabled )
> +        return -EINVAL;

Please explain in the commit message why PSCI 0.1 is not supported on ACPI.


Regards,

-- 
Julien Grall
