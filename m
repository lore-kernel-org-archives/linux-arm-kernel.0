From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Mar 2017 11:59:12 +0100
Subject: [PATCH v2 04/10] KVM: arm/arm64: vgic: Only set underflow when
 actually out of LRs
In-Reply-To: <20170321211059.8719-5-cdall@linaro.org>
References: <20170321211059.8719-1-cdall@linaro.org>
 <20170321211059.8719-5-cdall@linaro.org>
Message-ID: <4205a35a-d183-8c7b-3b3f-534a52e8ccab@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/17 21:10, Christoffer Dall wrote:
> We currently assume that all the interrupts in our AP list will be
> queued to LRs, but that's not necessarily the case, because some of them
> could have been migrated away to different VCPUs and only the VCPU
> thread itself can remove interrupts from its AP list.
> 
> Therefore, slightly change the logic to only setting the underflow
> interrupt when we actually run out of LRs.
> 
> As it turns out, this allows us to further simplify the handling in
> vgic_sync_hwstate in later patches.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
