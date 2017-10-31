From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 31 Oct 2017 04:27:51 +0000
Subject: [PATCH v4 16/21] KVM: arm64: Save/Restore guest DISR_EL1
In-Reply-To: <20171019145807.23251-17-james.morse@arm.com> (James Morse's
 message of "Thu, 19 Oct 2017 15:58:02 +0100")
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-17-james.morse@arm.com>
Message-ID: <86lgjs3prs.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19 2017 at  4:58:02 pm BST, James Morse <james.morse@arm.com> wrote:
> If we deliver a virtual SError to the guest, the guest may defer it
> with an ESB instruction. The guest reads the deferred value via DISR_EL1,
> but the guests view of DISR_EL1 is re-mapped to VDISR_EL2 when HCR_EL2.AMO
> is set.
>
> Add the KVM code to save/restore VDISR_EL2, and make it accessible to
> userspace as DISR_EL1.
>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
