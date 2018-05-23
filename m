From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 May 2018 15:59:36 +0100
Subject: [PATCH v10 14/18] KVM: arm64: Save host SVE context as appropriate
In-Reply-To: <1527005119-6842-15-git-send-email-Dave.Martin@arm.com>
References: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
 <1527005119-6842-15-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180523145935.ibbrnzgpmftan5t6@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 05:05:15PM +0100, Dave P Martin wrote:
> This patch adds SVE context saving to the hyp FPSIMD context switch
> path.  This means that it is no longer necessary to save the host
> SVE state in advance of entering the guest, when in use.
> 
> In order to avoid adding pointless complexity to the code, VHE is
> assumed if SVE is in use.  VHE is an architectural prerequisite for
> SVE, so there is no good reason to turn CONFIG_ARM64_VHE off in
> kernels that support both SVE and KVM.
> 
> Historically, software models exist that can expose the
> architecturally invalid configuration of SVE without VHE, so if
> this situation is detected at kvm_init() time then KVM will be
> disabled.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
