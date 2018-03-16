From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Mar 2018 16:07:10 +0000
Subject: [PATCH v6 11/26] KVM: arm64: Fix HYP idmap unmap when using
 52bit PA
In-Reply-To: <20180314165049.30105-12-marc.zyngier@arm.com>
References: <20180314165049.30105-1-marc.zyngier@arm.com>
 <20180314165049.30105-12-marc.zyngier@arm.com>
Message-ID: <20180316160710.pwa2nnh2ptebpjvd@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 04:50:34PM +0000, Marc Zyngier wrote:
> Unmapping the idmap range using 52bit PA is quite broken, as we
> don't take into account the right number of PGD entries, and rely
> on PTRS_PER_PGD. The result is that pgd_index() truncates the
> address, and we end-up in the weed.
> 
> Let's introduce a new unmap_hyp_idmap_range() that knows about this,
> together with a kvm_pgd_index() helper, which hides a bit of the
> complexity of the issue.
> 
> Fixes: 98732d1b189b ("KVM: arm/arm64: fix HYP ID map extension to 52 bits")
> Reported-by: James Morse <james.morse@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

It looks fine to me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
