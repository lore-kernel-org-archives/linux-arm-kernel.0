From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 May 2018 17:17:03 +0100
Subject: [PATCH v7 05/16] arm64: fpsimd: Generalise context saving for
 non-task contexts
In-Reply-To: <1525882385-29181-6-git-send-email-Dave.Martin@arm.com>
References: <1525882385-29181-1-git-send-email-Dave.Martin@arm.com>
 <1525882385-29181-6-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180510161702.vu6bwbnjlpq4erqk@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 05:12:54PM +0100, Dave P Martin wrote:
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
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
