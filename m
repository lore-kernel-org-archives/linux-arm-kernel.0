From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 May 2018 17:53:27 +0100
Subject: [PATCH v7 13/16] KVM: arm64: Remove eager host SVE state saving
In-Reply-To: <1525882385-29181-14-git-send-email-Dave.Martin@arm.com>
References: <1525882385-29181-1-git-send-email-Dave.Martin@arm.com>
 <1525882385-29181-14-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180510165327.dhj2ijbjsi3xvmqu@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 05:13:02PM +0100, Dave P Martin wrote:
> Now that the host SVE context can be saved on demand from Hyp,
> there is no longer any need to save this state in advance before
> entering the guest.
> 
> This patch removes the relevant call to
> kvm_fpsimd_flush_cpu_state().
> 
> Since the problem that function was intended to solve now no longer
> exists, the function and its dependencies are also deleted.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
