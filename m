From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Mar 2017 11:49:39 +0100
Subject: [PATCH v2 01/10] KVM: arm/arm64: vgic: Defer touching GICH_VMCR
 to vcpu_load/put
In-Reply-To: <20170321211059.8719-2-cdall@linaro.org>
References: <20170321211059.8719-1-cdall@linaro.org>
 <20170321211059.8719-2-cdall@linaro.org>
Message-ID: <5cdcadc0-c6c4-bb11-5a70-83f3a00a6532@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/17 21:10, Christoffer Dall wrote:
> From: Christoffer Dall <cdall@cs.columbia.edu>
> 
> We don't have to save/restore the VMCR on every entry to/from the guest,
> since on GICv2 we can access the control interface from EL1 and on VHE
> systems with GICv3 we can access the control interface from KVM running
> in EL2.
> 
> GICv3 systems without VHE become the rare case, which have to
> save/restore the register in the put/load functions by doing an extra
> jump to EL2 to access the EL2-only register state.
> 
> Note that userspace accesses may see out-of-date values if the VCPU is
> running while accessing the VGIC state via the KVM device API, but this
> is already the case and it is up to userspace to quiesce the CPUs before
> reading the CPU registers from the GIC for an up-to-date view.
> 
> Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
