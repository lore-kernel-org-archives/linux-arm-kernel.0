From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Mar 2017 12:03:03 +0100
Subject: [PATCH v2 05/10] KVM: arm/arm64: vgic: Get rid of unnecessary
 process_maintenance operation
In-Reply-To: <20170321211059.8719-6-cdall@linaro.org>
References: <20170321211059.8719-1-cdall@linaro.org>
 <20170321211059.8719-6-cdall@linaro.org>
Message-ID: <b94b9e68-ee7f-a3d7-2c1f-7df9ebbcadc6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/17 21:10, Christoffer Dall wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Since we always read back the LRs that we wrote to the guest and the
> MISR and EISR registers simply provide a summary of the configuration of
> the bits in the LRs, there is really no need to read back those status
> registers and process them.  We can might as well just signal the
                                  ^^^
Typo.

> notifyfd when folding the LR state and save some cycles in the process.
> 
> We now clear the underflow bit in the fold_lr_state functions as we only
> need to clear this bit if we had used all the LRs, so this is as good a
> place as any to do that work.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
