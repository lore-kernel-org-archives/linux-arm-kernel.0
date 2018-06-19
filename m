From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 16:20:19 +0100
Subject: [PATCHv3 10/19] arm64: convert native/compat syscall entry to C
In-Reply-To: <20180618120310.39527-11-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-11-mark.rutland@arm.com>
Message-ID: <20180619152019.rkgi2w7kndccawaf@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:03:01PM +0100, Mark Rutland wrote:
> Now that the syscall invocation logic is in C, we can migrate the rest
> of the syscall entry logic over, so that the entry assembly needn't look
> at the register values at all.
> 
> The SVE reset across syscall logic now unconditionally clears TIF_SVE,
> but sve_user_disable() will only write back to CPACR_EL1 when SVE is
> actually enabled.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Other than Dave's comments, it looks fine to me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
