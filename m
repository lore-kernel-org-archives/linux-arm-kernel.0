From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Jan 2017 16:35:21 +0000
Subject: [PATCH] arm64: handle sys and undef traps consistently
In-Reply-To: <1485533738-30062-1-git-send-email-mark.rutland@arm.com>
References: <1485533738-30062-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170127163521.GF27424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 04:15:38PM +0000, Mark Rutland wrote:
> If an EL0 instruction in the SYS class triggers an exception, do_sysintr
> looks for a sys64_hook matching the instruction, and if none is found,
> injects a SIGILL. This mirrors what we do for undefined instruction
> encodings in do_undefinstr, where we look for an undef_hook matching the
> instruction, and if none is found, inject a SIGILL.
> 
> Over time, new SYS instruction encodings may be allocated. Prior to
> allocation, exceptions resulting from these would be handled by
> do_undefinstr, whereas after allocation these may be handled by
> do_sysintr.
> 
> To ensure that we have consistent behaviour if and when this happens, it
> would be beneficial to have do_sysinstr fall back to do_undefinstr.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
