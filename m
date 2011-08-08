From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 08 Aug 2011 19:19:28 +0100
Subject: [PATCH 3/6] ARM: twd: register clockevents device before enabling
	PPI
In-Reply-To: <1312823424-9654-4-git-send-email-will.deacon@arm.com>
References: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
	<1312823424-9654-4-git-send-email-will.deacon@arm.com>
Message-ID: <4E4028B0.1040104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/11 18:10, Will Deacon wrote:
> The smp_twd clockevents driver currently enables the local timer PPI
> before the clockevents device is registered. This can lead to a kernel
> panic if a spurious timer interrupt is generated before registration
> has completed since the kernel will treat it as an IPI timer.
> 
> This patch moves the clockevents device registration before the IRQ
> unmasking so that we can always handle timer interrupts once they can
> occur.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

I'll rebase my timer patches on top of this one.

	M.
-- 
Jazz is not dead. It just smells funny...
