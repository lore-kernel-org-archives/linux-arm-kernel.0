From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 31 Oct 2017 06:32:53 +0000
Subject: [PATCH v4 21/21] KVM: arm64: Trap RAS error registers and set
 HCR_EL2's TERR & TEA
In-Reply-To: <20171019145807.23251-22-james.morse@arm.com> (James Morse's
 message of "Thu, 19 Oct 2017 15:58:07 +0100")
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-22-james.morse@arm.com>
Message-ID: <86y3nr3jze.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19 2017 at  4:58:07 pm BST, James Morse <james.morse@arm.com> wrote:
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> ARMv8.2 adds a new bit HCR_EL2.TEA which routes synchronous external
> aborts to EL2, and adds a trap control bit HCR_EL2.TERR which traps
> all Non-secure EL1&0 error record accesses to EL2.
>
> This patch enables the two bits for the guest OS, guaranteeing that
> KVM takes external aborts and traps attempts to access the physical
> error registers.
>
> ERRIDR_EL1 advertises the number of error records, we return
> zero meaning we can treat all the other registers as RAZ/WI too.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> [removed specific emulation, use trap_raz_wi() directly for everything,
>  rephrased parts of the commit message]
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
