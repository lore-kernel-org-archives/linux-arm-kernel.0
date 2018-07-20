From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jul 2018 11:13:12 +0100
Subject: [PATCH v9 0/4] support exception state migration and set
 VSESR_EL2 by user space
In-Reply-To: <20180719152425.6696-1-james.morse@arm.com>
References: <20180719152425.6696-1-james.morse@arm.com>
Message-ID: <c79facd4-0048-1733-1c8a-00fb2cd061b1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/18 16:24, James Morse wrote:
> Hi guys,
> 
> Changes since v8: expanded the documentation based on feedback.
> 
> This series adds the get/set events API to KVM for arm/arm64 so that
> user-space can migrate pending SError, (which KVM may have made pending
> as part of its device emulation), and for RAS make a new SError with a
> specific ESR value pending. (Only systems with the v8.2 RAS Extensions
> can specify an ESR, KVM advertises this capability with a new cap:
> KVM_CAP_ARM_INJECT_SERROR_ESR)
> 
> User-space can use this for emulation of the v8.2 CPU RAS features
> (using error nodes backed by mmio) or as part of NOTIFY_SEI which
> extends a v8.2 RAS SError to also have firmware-first CPER records.

Applied to kvmarm/next.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
