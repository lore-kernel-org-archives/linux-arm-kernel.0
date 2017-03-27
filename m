From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Mar 2017 12:04:26 +0100
Subject: [PATCH v2 10/10] KVM: arm/arm64: vgic: Improve sync_hwstate
 performance
In-Reply-To: <20170321211059.8719-11-cdall@linaro.org>
References: <20170321211059.8719-1-cdall@linaro.org>
 <20170321211059.8719-11-cdall@linaro.org>
Message-ID: <98d4f104-6c5e-9e2c-13ff-d4c8fbe23fd4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/17 21:10, Christoffer Dall wrote:
> There is no need to call any functions to fold LRs when we don't use any
> LRs and we don't need to mess with overflow flags, take spinlocks, or
> prune the AP list if the AP list is empty.
> 
> Note: list_empty is a single atomic read (uses READ_ONCE) and can
> therefore check if a list is empty or not without the need to take the
> spinlock protecting the list.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
