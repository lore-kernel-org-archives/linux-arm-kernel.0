From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 23:39:24 +0000
Subject: [RFC 06/18] arm: msm: implement proper dmb() for 7x27
In-Reply-To: <1263250057-26692-7-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-7-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100111233924.GL7925@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 02:47:25PM -0800, Daniel Walker wrote:
> From: Larry Bassel <lbassel@quicinc.com>
> 
> For 7x27 it is necessary to write to strongly
> ordered memory after executing the coprocessor 15
> instruction dmb instruction.
> 
> This is only for data barrier dmb().
> Note that the test for 7x27 is done on all MSM platforms
> (even ones such as 7201a whose kernel is distinct from
> that of 7x25/7x27).
> 
> Acked-by: Willie Ruan <wruan@quicinc.com>
> Signed-off-by: Larry Bassel <lbassel@quicinc.com>
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>

Can only see half of this change - what's the actual implementation of
arch_barrier_extra()?

I'd prefer not to include asm/memory.h into asm/system.h to avoid
needlessly polluting headers.
