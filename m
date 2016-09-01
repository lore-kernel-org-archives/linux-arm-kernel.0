From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 1 Sep 2016 15:55:29 +0100
Subject: [PATCH] arm64: KVM: VHE: reset PSTATE.PAN on entry to EL2
In-Reply-To: <1472740143-40061-1-git-send-email-vladimir.murzin@arm.com>
References: <1472740143-40061-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57C84161.3030607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/16 15:29, Vladimir Murzin wrote:
> SCTLR_EL2.SPAN bit controls what happens with the PSTATE.PAN bit on an
> exception. However, this bit has no effect on the PSTATE.PAN when
> HCR_EL2.E2H or HCR_EL2.TGE is unset. Thus when VHE is used and
> exception taken from a guest PSTATE.PAN bit left unchanged and we
> continue with a value guest has set.
> 
> To address that always reset PSTATE.PAN on entry from EL1.
> 
> Fixes: 1f364c8c48a0 ("arm64: VHE: Add support for running Linux in EL2 mode")
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Reviewed-by: James Morse <james.morse@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
