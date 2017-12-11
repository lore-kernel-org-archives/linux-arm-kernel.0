From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Dec 2017 09:45:37 +0000
Subject: [PATCH v2 10/36] KVM: arm64: Factor out fault info population and
 gic workarounds
In-Reply-To: <20171207170630.592-11-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
 <20171207170630.592-11-christoffer.dall@linaro.org>
Message-ID: <94f820d4-ec95-1079-ac85-14461bd25a5c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/17 17:06, Christoffer Dall wrote:
> The current world-switch function has functionality to detect a number
> of cases where we need to fixup some part of the exit condition and
> possibly run the guest again, before having restored the host state.
> 
> This includes populating missing fault info, emulating GICv2 CPU
> interface accesses when mapped at unaligned addresses, and emulating
> the GICv3 CPU interface on systems that need it.
> 
> As we are about to have an alternative switch function for VHE systems,
> but VHE systems still need the same early fixup logic, factor out this
> logic into a separate function that can be shared by both switch
> functions.
> 
> No functional change.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
