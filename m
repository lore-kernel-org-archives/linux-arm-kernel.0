From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 09:01:55 +0000
Subject: RFC [PATCH 2/9] Initial makefiles and Kconfigs for the lcp32xx
	mach
In-Reply-To: <083DF309106F364B939360100EC290F804F54D560B@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F54D560B@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20091121090155.GA7998@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 02:11:16AM +0100, Kevin Wells wrote:
> +config NODES_SHIFT
> +	default 0 if !ARCH_DISCONTIGMEM_ENABLE
> +	default 2 if ARCH_DISCONTIGMEM_ENABLE
> +
> +config ARCH_DISCONTIGMEM_ENABLE
> + 	bool "Enable support for non-contiguous memory on 64Mx2 systems"
> + 	default n
> + 	help
> +	    Enable this option for designs with DRAM devices on both DRAM
> +            chip selects DYCS0 and DYCS1. Do not enable this option if you
> +            only have 1 DRAM device on DYCS0

Please don't redefine already defined Kconfig constants in your own
file.

> +source "kernel/Kconfig.hz"

Please don't include this; modify the definition in arch/arm/Kconfig
instead.

The problem is that if you redefine these symbols, they will affect the
other versions, and you could end up inadvertently breaking other
platforms.

I do wish the Kconfig parser would warn about duplicate definitions.
