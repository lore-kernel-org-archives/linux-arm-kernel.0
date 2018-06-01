From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 1 Jun 2018 15:41:30 +0100
Subject: [PATCHv2 11/19] arm64: don't reload GPRs after apply_ssbd
In-Reply-To: <20180601112441.37810-12-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
 <20180601112441.37810-12-mark.rutland@arm.com>
Message-ID: <57f6f0ca-8256-d642-fd59-034b989dc5c8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/18 12:24, Mark Rutland wrote:
> Now that all of the syscall logic works on the saved pt_regs, apply_ssbd
> can safely corrupt x0-x3 in the entry paths, and we no longer need to
> restore them. So let's remotve the logic doing so.

remove*

> 
> With that logic gone, we can fold the branch target into the macro, so
> that callers need not deal with this. GAS provides \@, which provides a
> unique value per macro invocation, which we can use to create a unique
> label.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
