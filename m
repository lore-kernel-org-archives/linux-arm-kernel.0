From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 08:42:11 +0000
Subject: [PATCH 01/03] ARM: mach-shmobile: SMP base support
In-Reply-To: <20101214075655.11275.95963.sendpatchset@t400s>
References: <20101214075647.11275.25933.sendpatchset@t400s>
	<20101214075655.11275.95963.sendpatchset@t400s>
Message-ID: <20101217084211.GZ9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 04:56:55PM +0900, Magnus Damm wrote:
> +/*
> + * Reset vector for secondary CPUs.
> + * This will be mapped at address 0 by SBAR register.
> + * We need _long_ jump to the physical address.
> + */
> +	.align  12
> +ENTRY(shmobile_secondary_vector)
> +	ldr     pc, 1f
> +1:	.long   secondary_startup - CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START

BTW, why not use - PAGE_OFFSET + PHYS_OFFSET here?  Both these macros
are available for use in assembly code - just include asm/memory.h.
