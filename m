From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 21 Nov 2009 14:52:29 +0530
Subject: RFC [PATCH 2/9] Initial makefiles and Kconfigs for the lcp32xx
	mach
In-Reply-To: <20091121090155.GA7998@n2100.arm.linux.org.uk>
References: <083DF309106F364B939360100EC290F804F54D560B@eu1rdcrdc1wx030.exi.nxp.com>
	<20091121090155.GA7998@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BBC43ACB@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Russell King -
> ARM Linux
> Sent: Saturday, November 21, 2009 2:32 PM
> To: Kevin Wells
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: RFC [PATCH 2/9] Initial makefiles and Kconfigs for the
> lcp32xx mach
> 
> On Fri, Nov 20, 2009 at 02:11:16AM +0100, Kevin Wells wrote:
> > +config NODES_SHIFT
> > +	default 0 if !ARCH_DISCONTIGMEM_ENABLE
> > +	default 2 if ARCH_DISCONTIGMEM_ENABLE
> > +
> > +config ARCH_DISCONTIGMEM_ENABLE
> > + 	bool "Enable support for non-contiguous memory on 64Mx2
> systems"
> > + 	default n
> > + 	help
> > +	    Enable this option for designs with DRAM devices on both
> DRAM
> > +            chip selects DYCS0 and DYCS1. Do not enable this
> option if you
> > +            only have 1 DRAM device on DYCS0
> 
> Please don't redefine already defined Kconfig constants in your own
> file.
> 
> > +source "kernel/Kconfig.hz"
> 
> Please don't include this; modify the definition in arch/arm/Kconfig
> instead.
> 
> The problem is that if you redefine these symbols, they will affect
> the
> other versions, and you could end up inadvertently breaking other
> platforms.
> 
> I do wish the Kconfig parser would warn about duplicate definitions.

I think it does warn with some thing like
warning: override: reassigning to symbol XXXXX
