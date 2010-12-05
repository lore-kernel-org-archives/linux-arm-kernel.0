From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 5 Dec 2010 21:47:25 +0000
Subject: [PATCH 2/5] ARM: GIC: Remove MMIO address from gic_cpu_init,
	rename to gic_secondary_init
In-Reply-To: <E1PPCrW-0004xS-L5@rmk-PC.arm.linux.org.uk>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
	<E1PPCrW-0004xS-L5@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTi=exHys8FBAvLmk0HHQu8w+a3=WzGYVaRtkWcq_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2010 11:34, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> We don't need to re-pass the base address for the CPU interfaces to the
> GIC for secondary CPUs, as it will never be different from the boot CPU
> - and even if it was, we'd overwrite the boot CPU's base address.
>
> Get rid of this argument, and rename to gic_secondary_init().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

(minor issue, maybe a comment for gic_secondary_init just in case
anyone things about primary and secondary GICs).
