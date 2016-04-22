From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 11:51:10 +0100
Subject: [PATCH v11 11/17] ARM: XEN: Move xen_early_init() before
 efi_init()
In-Reply-To: <1460030614-16112-12-git-send-email-zhaoshenglong@huawei.com>
References: <1460030614-16112-1-git-send-email-zhaoshenglong@huawei.com>
 <1460030614-16112-12-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160422105110.GE2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 08:03:28PM +0800, Shannon Zhao wrote:
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -320,6 +320,7 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	cpu_uninstall_idmap();
>  
> +	xen_early_init();
>  	efi_init();
>  	arm64_memblock_init();
>  
> @@ -341,7 +342,6 @@ void __init setup_arch(char **cmdline_p)
>  	} else {
>  		psci_acpi_init();
>  	}
> -	xen_early_init();
>  
>  	cpu_read_bootcpu_ops();
>  	smp_init_cpus();

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
