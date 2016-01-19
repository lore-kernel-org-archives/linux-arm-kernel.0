From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Jan 2016 16:32:43 +0000
Subject: [PATCH] arm64: KVM: Obey RES0/1 reserved bits when setting
 CPTR_EL2
In-Reply-To: <1453220418-24744-1-git-send-email-Dave.Martin@arm.com>
References: <1453220418-24744-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <569E652B.8040202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/16 16:20, Dave Martin wrote:
> Some bits in CPTR are defined as RES1 in the architecture.  Setting
> these bits to zero may unintentionally enable future architecture
> extensions, allowing guests to use them without supervision by the host.
> 
> This would be bad: for forwards compatibility, this patch makes
> sure the affected bits are always written with 1, not 0.
> 
> This patch only addresses CPTR_EL2.  Initialisation of other system
> registers may still need review.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Thanks for putting this together:

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Unless someone has an objection, I plan to queue this post -rc1.

	M.
-- 
Jazz is not dead. It just smells funny...
