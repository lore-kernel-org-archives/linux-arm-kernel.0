From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 09:34:07 +0000
Subject: RFC [PATCH 2/9] Initial makefiles and Kconfigs for the lcp32xx
	mach
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BBC43ACB@dbde02.ent.ti.com>
References: <083DF309106F364B939360100EC290F804F54D560B@eu1rdcrdc1wx030.exi.nxp.com>
	<20091121090155.GA7998@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BBC43ACB@dbde02.ent.ti.com>
Message-ID: <20091121093407.GC7998@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2009 at 02:52:29PM +0530, Shilimkar, Santosh wrote:
> I think it does warn with some thing like
> warning: override: reassigning to symbol XXXXX

It's silent, because there are situations you do want to override other
symbols - eg, FRAME_POINTER.  This isn't a problem because the ARM
Kconfigs don't get included into non-ARM builds.

However, all sub-architecture Kconfigs are included for all ARM Kconfig
runs, which means the contents of them can potentially be affected by
each other.  We need be disciplined and only have configuration options
defined at one level - if they are already defined in arch/arm/Kconfig,
then they should not be redefined in any arch/arm/*/Kconfig*.
