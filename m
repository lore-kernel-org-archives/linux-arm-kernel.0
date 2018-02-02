From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 2 Feb 2018 17:51:11 +0000
Subject: [PATCH 2/2] arm64: entry: Apply BP hardening for suspicious
 interrupts from EL0
In-Reply-To: <1517592700-26497-3-git-send-email-will.deacon@arm.com>
References: <1517592700-26497-1-git-send-email-will.deacon@arm.com>
 <1517592700-26497-3-git-send-email-will.deacon@arm.com>
Message-ID: <145cc01f-0a7b-5592-03ac-ac045677185c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/18 17:31, Will Deacon wrote:
> It is possible to take an IRQ from EL0 following a branch to a kernel
> address in such a way that the IRQ is prioritised over the instruction
> abort. Whilst an attacker would need to get the starts to align here,
> it might be sufficient with enough calibration so perform BP hardening
> in the rare case that we see a kernel address in the ELR when handling
> an IRQ from EL0.
> 
> Reported-by: Dan Hettena <dhettena@nvidia.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
