From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 04 Sep 2015 15:51:44 +0100
Subject: [PATCH 2/2] arm/arm64: KVM: arch timer: Reset CNTV_CTL to 0
In-Reply-To: <20150904144719.GJ5171@cbox>
References: <1441376679-8341-1-git-send-email-christoffer.dall@linaro.org>
 <1441376679-8341-3-git-send-email-christoffer.dall@linaro.org>
 <20150904144719.GJ5171@cbox>
Message-ID: <55E9B000.9040502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/15 15:47, Christoffer Dall wrote:
> On Fri, Sep 04, 2015 at 04:24:39PM +0200, Christoffer Dall wrote:
>> Provide a better quality of implementation and be architecture compliant
>> on ARMv7 for the architected timer by resetting the CNTV_CTL to 0 on
>> reset of the timer, and call kvm_timer_update_state(vcpu) at the same
>> time, ensuring the timer output is not asserted after, for example, a
>> PSCI system reset.
> 
> forgot to remove the bit about kvm_timer_update_state(vcpu) which is no
> longer valid when these patches are merged before the rework series.
> 
> Marc, if you're otherwise happy with this patch, can you fix this up at
> commit time?

No problem, I can fix the commit message on applying the patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
