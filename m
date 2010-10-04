From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Oct 2010 19:34:50 +0100
Subject: [PATCH 02/10] ARM: hotplug cpu: setup 1:1 map for entire
	kernel image for secondary CPUs
In-Reply-To: <alpine.LFD.2.00.1010041417470.3107@xanadu.home>
References: <E1P2oXT-00020I-MY@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1010041417470.3107@xanadu.home>
Message-ID: <20101004183450.GA25241@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 02:20:47PM -0400, Nicolas Pitre wrote:
> On Mon, 4 Oct 2010, Russell King - ARM Linux wrote:
> 
> > +static inline void identity_mapping_add(pgd_t *pgd, unsigned long start,
> > +	unsigned long end)
> > +{
> > +	unsigned long addr, prot;
> > +	pmd_t *pmd;
> > +
> > +	prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE;
> > +	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
> > +		prot |= PMD_BIT4;
> 
> Is there any SMP capable implementation where the above test is 
> useful?

Probably not, but if someone decides to clean that up (and copy it
into arch/arm/mm/mmu.c for setup_mm_for_reboot()) I'd rather it be
there.
