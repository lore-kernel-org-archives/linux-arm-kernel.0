From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 10:10:19 +0100
Subject: [PATCH v3 14/40] Subject: ARM: mm: proc-arm6_7: Use the new
	processor struct macros
In-Reply-To: <1308851448-25139-15-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
	<1308851448-25139-15-git-send-email-dave.martin@linaro.org>
Message-ID: <20110707091019.GI8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2011 at 06:50:22PM +0100, Dave Martin wrote:
> +.macro arm67_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, \
> +	cpu_mm_mmu_flags:req, cpu_flush:req, cpu_proc_funcs:req
> +		.type	__\name\()_proc_info, #object
> +__\name\()_proc_info:
> +		.long	\cpu_val
> +		.long	\cpu_mask
> +		.long	\cpu_mm_mmu_flags
>  		.long   PMD_TYPE_SECT | \
>  			PMD_BIT4 | \
>  			PMD_SECT_AP_WRITE | \
>  			PMD_SECT_AP_READ
> -		b	__arm6_setup
> +		b	\cpu_flush
>  		.long	cpu_arch_name
>  		.long	cpu_elf_name
>  		.long	HWCAP_SWP | HWCAP_26BIT
> -		.long	cpu_arm6_name
> -		.long	arm6_processor_functions
> +		.long	\cpu_name\()

I don't think you want the extra \() there.
