From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Mar 2017 11:52:23 +0100
Subject: [PATCH v2 02/10] KVM: arm/arm64: vgic: Avoid flushing vgic state
 when there's no pending IRQ
In-Reply-To: <20170321211059.8719-3-cdall@linaro.org>
References: <20170321211059.8719-1-cdall@linaro.org>
 <20170321211059.8719-3-cdall@linaro.org>
Message-ID: <bd56c2b3-bd4e-dd42-61bf-2ec1f81dba38@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/17 21:10, Christoffer Dall wrote:
> From: Shih-Wei Li <shihwei@cs.columbia.edu>
> 
> We do not need to flush vgic states in each world switch unless
> there is pending IRQ queued to the vgic's ap list. We can thus reduce
> the overhead by not grabbing the spinlock and not making the extra
> function call to vgic_flush_lr_state.
> 
> Note: list_empty is a single atomic read (uses READ_ONCE) and can
> therefore check if a list is empty or not without the need to take the
> spinlock protecting the list.
> 
> Signed-off-by: Shih-Wei Li <shihwei@cs.columbia.edu>
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
