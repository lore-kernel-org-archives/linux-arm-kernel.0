From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 2 Jul 2018 14:23:00 +0100
Subject: [PATCH] arm64: kexec: always reset to EL2 if present
In-Reply-To: <20180702131753.12949-1-mark.rutland@arm.com>
References: <20180702131753.12949-1-mark.rutland@arm.com>
Message-ID: <5259486f-126c-a343-c279-628846603cb6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/18 14:17, Mark Rutland wrote:
> Currently machine_kexec() doesn't reset to EL2 in the case of a
> crashdump kernel. This leaves potentially dodgy state active at EL2, and
> means that if the crashdump kernel attempts to online secondary CPUs,
> these will be booted as mismatched ELs.
> 
> Let's reset to EL2, as we do in all other cases, and simplify things. If
> EL2 state is corrupt, things are already sufficiently bad that kdump is
> unlikely to work, and it's best-effort regardless.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
