From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 16:23:07 +0100
Subject: [PATCHv3 11/19] arm64: don't reload GPRs after apply_ssbd
In-Reply-To: <20180618120310.39527-12-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-12-mark.rutland@arm.com>
Message-ID: <20180619152306.iz55qshhqsnql5vy@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:03:02PM +0100, Mark Rutland wrote:
> Now that all of the syscall logic works on the saved pt_regs, apply_ssbd
> can safely corrupt x0-x3 in the entry paths, and we no longer need to
> restore them. So let's remove the logic doing so.
> 
> With that logic gone, we can fold the branch target into the macro, so
> that callers need not deal with this. GAS provides \@, which provides a
> unique value per macro invocation, which we can use to create a unique
> label.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
