From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 14 Jun 2018 13:45:00 +0100
Subject: [PATCH 0/4] KVM: arm64: FPSIMD/SVE fixes for 4.17
In-Reply-To: <1528976039-25826-1-git-send-email-Dave.Martin@arm.com>
References: <1528976039-25826-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180614124457.GM22983@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2018 at 12:33:55PM +0100, Dave Martin wrote:
> This series contains fixes for some issues observed since the KVM arm64
> pull request for 4.17.

*ahem*, that should read 4.18.

> The first patch (from Mark Rutland) adds a straightforward helper to
> modify particular bits in a system register conditionally.  This is used
> by patch 3 (though obviously it could be coded round and patch 1
> dropped, if preferred).
> 
> See other patches for details of the individual fixes.
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
>  arch/arm64/include/asm/sysreg.h   | 11 ++++++++++
>  arch/arm64/kvm/fpsimd.c           | 46 +++++++++++++++++++++++++++++----------
>  3 files changed, 47 insertions(+), 11 deletions(-)
> 
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
