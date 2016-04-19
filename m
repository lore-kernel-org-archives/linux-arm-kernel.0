From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Apr 2016 16:11:03 +0100
Subject: [PATCH v7 05/16] arm64: kvm: Move lr save/restore from
 do_el2_call into EL1
In-Reply-To: <1459529620-22150-6-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-6-git-send-email-james.morse@arm.com>
Message-ID: <57164A87.6060605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/16 17:53, James Morse wrote:
> Today the 'hvc' calling kvm or the hyp-stub is expected to preserve all
> registers. Kvm saves/restores the registers it needs on the EL2 stack using
> do_el2_call. The hyp-stub has no stack, later patches need at least one
> register they can use.
> 
> Allow theses calls to clobber the link register, and add code to
> save/restore this register at the call sites.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
