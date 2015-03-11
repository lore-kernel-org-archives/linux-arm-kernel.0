From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Mar 2015 15:07:21 +0000
Subject: [PATCH] arm/arm64: KVM: Kill CONFIG_KVM_ARM_{VGIC,TIMER}
In-Reply-To: <1426083780-27588-1-git-send-email-christoffer.dall@linaro.org>
References: <1426083780-27588-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <55005A29.9060202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/15 14:23, Christoffer Dall wrote:
> We can definitely decide at run-time whether to use the GIC and timers
> or not, and the extra code and data structures that we allocate space
> for is really negligable with this config option, so I don't think it's
> worth the extra complexity of always having to define stub static
> inlines.  The !CONFIG_KVM_ARM_VGIC/TIMER case is pretty much an untested
> code path anyway, so we're better off just getting rid of it.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks for putting this together.

	M.
-- 
Jazz is not dead. It just smells funny...
