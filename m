From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 15:47:49 +0000
Subject: [PATCH 2/2] arm64: move !VHE work to end of el2_setup
In-Reply-To: <1487170457-17986-3-git-send-email-mark.rutland@arm.com>
References: <1487170457-17986-1-git-send-email-mark.rutland@arm.com>
 <1487170457-17986-3-git-send-email-mark.rutland@arm.com>
Message-ID: <ae1198c7-84f6-1795-8850-12858cb25a3c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/17 14:54, Mark Rutland wrote:
> We only need to initialise sctlr_el1 if we're installing an EL2 stub, so
> we may as well defer this until we're doing so. Similarly, we can defer
> intialising CPTR_EL2 until then, as we do not access any trapped
> functionality as part of el2_setup.
> 
> This patch modified el2_setup accordingly, allowing us to remove a
> branch and simplify the code flow.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
