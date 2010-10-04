From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 04 Oct 2010 14:20:47 -0400 (EDT)
Subject: [PATCH 02/10] ARM: hotplug cpu: setup 1:1 map for entire kernel
	image for secondary CPUs
In-Reply-To: <E1P2oXT-00020I-MY@rmk-PC.arm.linux.org.uk>
References: <E1P2oXT-00020I-MY@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1010041417470.3107@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Oct 2010, Russell King - ARM Linux wrote:

> +static inline void identity_mapping_add(pgd_t *pgd, unsigned long start,
> +	unsigned long end)
> +{
> +	unsigned long addr, prot;
> +	pmd_t *pmd;
> +
> +	prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE;
> +	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
> +		prot |= PMD_BIT4;

Is there any SMP capable implementation where the above test is 
useful?


Nicolas
