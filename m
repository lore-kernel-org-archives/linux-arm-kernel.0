From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Jan 2016 12:15:25 +0000
Subject: [PATCH 1/2] arm64: entry: remove pointless SPSR mode check
In-Reply-To: <1452015215-29506-1-git-send-email-mark.rutland@arm.com>
References: <20160105172106.GA7088@leverpostej>
 <1452015215-29506-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160106121524.GL6301@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 05:33:34PM +0000, Mark Rutland wrote:
> In work_pending  we may skip work if the stacked SPSR value represents
> anything other than an EL0 context. We then immediately invoke the
> kernel_exit 0 macro as part of ret_to_user, assuming a return to EL0.
> This is somewhat confusing.
> 
> We use work_pending as part of the ret_to_user/ret_fast_syscall state
> machine. We only use ret_fast_syscall in the return from an SVC issued
> from EL0. We use ret_to_user for return from EL0 exception handlers and
> also for return from ret_from_fork in the case the task was not a kernel
> thread (i.e. it is a user task).
> 
> Thus in all cases the stacked SPSR value must represent an EL0 context,
> and the check is redundant. This patch removes it, along with the now
> unused no_work_pending label.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chris Metcalf <cmetcalf@ezchip.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
