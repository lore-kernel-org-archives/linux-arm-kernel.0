From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 17 Nov 2015 11:58:30 +0000
Subject: [PATCH v3 38/62] arm/acpi: Add placeholder for efi and acpi load
 address
In-Reply-To: <1447753261-7552-39-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-39-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564B1666.4060008@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> EFI table, memory description table and some of acpi tables will be
> placed after DOM0 memory space. Add placeholder for the starting address
> for loading in DOM0 and the size of new added tables. Also add a
> placeholder to store the new created tables.
> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/include/asm-arm/domain.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/xen/include/asm-arm/domain.h b/xen/include/asm-arm/domain.h
> index 1e61f30..91272e5 100644
> --- a/xen/include/asm-arm/domain.h
> +++ b/xen/include/asm-arm/domain.h
> @@ -125,6 +125,11 @@ struct arch_domain
>      } vuart;
>  
>      unsigned int evtchn_irq;
> +#ifdef CONFIG_ACPI
> +    void *efi_acpi_table;
> +    paddr_t efi_acpi_gpa;
> +    paddr_t efi_acpi_len;
> +#endif

Why do you need this in the arch_domain? AFAICT those 3 variables should
only be used while building DOM0, so a better place would be in struct
kernel_info (see xen/arch/arm/kernel.h).

>  }  __cacheline_aligned;
>  
>  struct arch_vcpu
> 


Regards,


-- 
Julien Grall
