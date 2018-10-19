From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Oct 2018 15:38:03 +0100
Subject: [PATCH] arm64: KVM: Guests can skip __install_bp_hardening_cb()s
 HYP work
In-Reply-To: <de8be744-525a-2b75-ef77-e66d7fbabc40@arm.com>
References: <20180921204919.5790-1-james.morse@arm.com>
 <de8be744-525a-2b75-ef77-e66d7fbabc40@arm.com>
Message-ID: <20181019143803.GC3985@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 11:17:32AM +0100, Marc Zyngier wrote:
> On 21/09/18 21:49, James Morse wrote:
> > enable_smccc_arch_workaround_1() passes NULL as the hyp_vecs start and
> > end if the HVC conduit is in use, and ARM_SMCCC_ARCH_WORKAROUND_1 is
> > detected.
> > 
> > If the guest kernel happened to be built with KVM_INDIRECT_VECTORS,
> > we go on to allocate a slot, memcpy() the empty workaround in and
> > do the appropriate cache maintenance.
> > 
> > This works as we always tell memcpy() the range is 0, so it never
> > accesses the NULL src pointer, but we still do the cache maintenance.
> > 
> > If hyp_vecs_start is NULL we know we're a guest, just update the fn
> > like the !KVM_INDIRECT_VECTORS version.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Catalin: could you sneak this one in for 4.20? It is strictly a KVM
> patch, but its location makes it more suitable for the arm64 tree...

Done.

-- 
Catalin
