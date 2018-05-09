From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 May 2018 09:27:10 +0100
Subject: [PATCH v6 06/15] KVM: arm64: Repurpose vcpu_arch.debug_flags for
 general-purpose flags
In-Reply-To: <1525797900-5548-7-git-send-email-Dave.Martin@arm.com>
References: <1525797900-5548-1-git-send-email-Dave.Martin@arm.com>
 <1525797900-5548-7-git-send-email-Dave.Martin@arm.com>
Message-ID: <1e3b403f-6ec0-e8d1-0137-739469dd6900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/18 17:44, Dave Martin wrote:
> In struct vcpu_arch, the debug_flags field is used to store debug-
> related flags about the vcpu state.
> 
> Since we are about to add some more flags related to FPSIMD and
> SVE, it makes sense to add them to the existing flags field rather
> than adding new fields.  Since there is only one debug_flags flag
> defined so far, there is plenty of free space for expansion.
> 
> In preparation for adding more flags, this patch renames the
> debug_flags field to simply "flags", and updates comments
> appropriately.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
