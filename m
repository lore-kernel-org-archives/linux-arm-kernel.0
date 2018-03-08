From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Mar 2018 13:59:45 +0000
Subject: [PATCH v5 19/23] arm64: KVM: Allow far branches from vector
 slots to the main vectors
In-Reply-To: <20180301155538.26860-20-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-20-marc.zyngier@arm.com>
Message-ID: <20180308135944.oqrm5n7hmvitknxu@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 03:55:34PM +0000, Marc Zyngier wrote:
> So far, the branch from the vector slots to the main vectors can at
> most be 4GB from the main vectors (the reach of ADRP), and this
> distance is known at compile time. If we were to remap the slots
> to an unrelated VA, things would break badly.
> 
> A way to achieve VA independence would be to load the absolute
> address of the vectors (__kvm_hyp_vector), either using a constant
> pool or a series of movs, followed by an indirect branch.
> 
> This patches implements the latter solution, using another instance
> of a patching callback.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
