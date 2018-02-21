From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 21 Feb 2018 12:21:11 +0000
Subject: [PATCH v4 17/40] KVM: arm64: Move userspace system registers into
 separate function
In-Reply-To: <20180215210332.8648-18-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-18-christoffer.dall@linaro.org>
Message-ID: <86bmgileiw.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Feb 2018 21:03:09 +0000,
Christoffer Dall wrote:
> 
> There's a semantic difference between the EL1 registers that control
> operation of a kernel running in EL1 and EL1 registers that only control
> userspace execution in EL0.  Since we can defer saving/restoring the
> latter, move them into their own function.
> 
> ACTLR_EL1 is not used by a VHE host, so we can move this register into
> the EL1 state which is not saved/restored for a VHE host.

Nit: maybe worth adding a reference to the D10.2.1 comment in the
ARMv8 ARM that indicates the "recommended" behaviour of this register?

> 
> We also take this chance to rename the function saving/restoring the
> remaining system register to make it clear this function deals with
> the EL1 system registers.
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.
