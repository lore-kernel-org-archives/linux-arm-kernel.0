From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 21 Feb 2018 14:16:36 +0000
Subject: [PATCH v4 25/40] KVM: arm64: Introduce framework for accessing
 deferred sysregs
In-Reply-To: <20180215210332.8648-26-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-26-christoffer.dall@linaro.org>
Message-ID: <868tbml96j.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Feb 2018 21:03:17 +0000,
Christoffer Dall wrote:
> 
> We are about to defer saving and restoring some groups of system
> registers to vcpu_put and vcpu_load on supported systems.  This means
> that we need some infrastructure to access system registes which
> supports either accessing the memory backing of the register or directly
> accessing the system registers, depending on the state of the system
> when we access the register.
> 
> We do this by defining read/write accessor functions, which can handle
> both "immediate" and "deferrable" system registers.  Immediate registers
> are always saved/restored in the world-switch path, but deferrable
> registers are only saved/restored in vcpu_put/vcpu_load when supported
> and sysregs_loaded_on_cpu will be set in that case.
> 
> Note that we don't use the deferred mechanism yet in this patch, but only
> introduce infrastructure.  This is to improve convenience of review in
> the subsequent patches where it is clear which registers become
> deferred.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	     M.

-- 
Jazz is not dead, it just smell funny.
