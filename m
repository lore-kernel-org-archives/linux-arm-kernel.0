From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Apr 2010 15:15:33 +0100
Subject: [RFC] Prohibit ioremap() on kernel managed RAM
In-Reply-To: <20100408094818.GD31407@n2100.arm.linux.org.uk>
References: <20100408094818.GD31407@n2100.arm.linux.org.uk>
Message-ID: <1272032133.15107.53.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-04-08 at 10:48 +0100, Russell King - ARM Linux wrote:
> ARMv6 and above have a restriction whereby aliasing virtual:physical
> mappings must not have differing memory type and sharability
> attributes.  Strictly, this covers the memory type (strongly ordered,
> device, memory), cache attributes (uncached, write combine, write
> through, write back read alloc, write back write alloc) and the
> shared bit.
> 
> However, using ioremap() and its variants on system RAM results in
> mappings which differ in these attributes from the main system RAM
> mapping.  Other architectures which similar restrictions approch this
> problem in the same way - they do not permit ioremap on main system
> RAM.
> 
> Make ARM behave in the same way, with a WARN_ON() such that users can
> be traced and an alternative approach found.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

BTW, why not do this for /dev/mem mappings with O_SYNC? I think I sent
you a patch some time ago but I can re-post it.

-- 
Catalin
