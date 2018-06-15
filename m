From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 15 Jun 2018 16:56:41 +0100
Subject: [PATCH v2 0/4] KVM: arm64: FPSIMD/SVE fixes for 4.17
In-Reply-To: <1529077646-2848-1-git-send-email-Dave.Martin@arm.com>
References: <1529077646-2848-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180615155640.GP22983@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 04:47:22PM +0100, Dave Martin wrote:
> This series contains fixes for some issues observed since the KVM arm64
> pull request for 4.17.

Groan.  Again, this should read "4.18".  Apologies for the confusion!
Fixed locally in case I respin.

Cheers
---Dave

> 
> It supersedes the previous v1 [1].
> 
> The first patch (from Mark Rutland) adds a straightforward helper to
> modify particular bits in a system register conditionally.  This is used
> by patch 3 (though obviously it could be coded round and patch 1
> dropped, if preferred).
> 
> See other patches for details of the individual fixes and changes from
> the previous posting.
> 
> [1] [PATCH 0/4] KVM: arm64: FPSIMD/SVE fixes for 4.17
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/584107.html
> 
> Dave Martin (3):
>   KVM: arm64: Don't mask softirq with IRQs disabled in vcpu_put()
>   KVM: arm64/sve: Fix SVE trap restoration for non-current tasks
>   KVM: arm64: Avoid mistaken attempts to save SVE state for vcpus
> 
> Mark Rutland (1):
>   arm64: introduce sysreg_clear_set()
> 
>  arch/arm64/include/asm/kvm_host.h |  1 +
>  arch/arm64/include/asm/sysreg.h   | 11 +++++++++++
>  arch/arm64/kvm/fpsimd.c           | 36 +++++++++++++++++++++++++++---------
>  3 files changed, 39 insertions(+), 9 deletions(-)
> 
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
