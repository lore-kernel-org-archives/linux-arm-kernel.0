From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 8 May 2018 10:20:36 +0100
Subject: [PATCH v5 05/14] arm64: fpsimd: Generalise context saving for
 non-task contexts
In-Reply-To: <1525449935-31424-6-git-send-email-Dave.Martin@arm.com>
References: <1525449935-31424-1-git-send-email-Dave.Martin@arm.com>
 <1525449935-31424-6-git-send-email-Dave.Martin@arm.com>
Message-ID: <f4ef5d12-0543-b078-6caf-b579bad56fb6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/18 17:05, Dave Martin wrote:
> In preparation for allowing non-task (i.e., KVM vcpu) FPSIMD
> contexts to be handled by the fpsimd common code, this patch adapts
> task_fpsimd_save() to save back the currently loaded context,
> removing the explicit dependency on current.
> 
> The relevant storage to write back to in memory is now found by
> examining the fpsimd_last_state percpu struct.
> 
> fpsimd_save() does nothing unless TIF_FOREIGN_FPSTATE is clear, and
> fpsimd_last_state is updated under local_bh_disable() or
> local_irq_disable() everywhere that TIF_FOREIGN_FPSTATE is cleared:
> thus, fpsimd_save() will write back to the correct storage for the
> loaded context.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
