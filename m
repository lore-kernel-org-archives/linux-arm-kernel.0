From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Sep 2012 17:36:30 +0100
Subject: [RESEND PATCH 0/3] New algorithm for ASID allocation and rollover
In-Reply-To: <1348157770-9647-1-git-send-email-will.deacon@arm.com>
References: <1348157770-9647-1-git-send-email-will.deacon@arm.com>
Message-ID: <505B460E.8050909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/12 17:16, Will Deacon wrote:

Hi Will,

> This is a resend of the patches originally posted here:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/114344.html
> 
> I received some minor comments in that thread, but nothing that warranted
> any changes to the code. Due to the nature of these changes, I would
> very much like to put these into -next for some exposure prior to merging.
> 
> Again, all feedback welcome.
> 
> Will
> 
> 
> Will Deacon (3):
>   ARM: mm: remove IPI broadcasting on ASID rollover
>   ARM: mm: avoid taking ASID spinlock on fastpath
>   ARM: mm: use bitmap operations when allocating new ASIDs
> 
>  arch/arm/include/asm/mmu.h         |   11 +--
>  arch/arm/include/asm/mmu_context.h |   82 +--------------
>  arch/arm/mm/context.c              |  207 +++++++++++++++++++-----------------
>  3 files changed, 115 insertions(+), 185 deletions(-)

FWIW, after using this series on VE A15 (both as a host and as KVM guests):

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
