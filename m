From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 03 Jul 2015 13:14:15 +0100
Subject: [RFC 08/17] kvm: arm/arm64: implement kvm_arm_[halt, resume]_guest
In-Reply-To: <55967848.5050204@linaro.org>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
 <1435843047-6327-9-git-send-email-eric.auger@linaro.org>
 <55967848.5050204@linaro.org>
Message-ID: <55967C97.5010502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/15 12:55, Eric Auger wrote:
> Christoffer, Marc,
> On 07/02/2015 03:17 PM, Eric Auger wrote:
>> On halt, the guest is forced to exit and prevented from being
>> re-entered. This is synchronous.
>>
>> Those two operations will be needed for IRQ forwarding setting.
>>
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> would you agree to handle this ARM functionality separately from the
> forwarding series?
> 
> This includes 2 patch files, that one +
> https://lkml.org/lkml/2015/7/2/288. This functionality is needed for
> forwarding control since when changing the forwarding state we need to
> "freeze" the state of the physical/virtual IRQ to undertake proper
> actions. Stopping the guest makes sure it won't deactivate the virtual
> IRQ while we are doing state change actions.
> 
> The forwarding series is quite heterogeneous (VFIO platform driver,
> vgic, irq bypass manager) and I think it would simplify the review process.
> 
> Please let me know if you agree. If yes, I will post a separate series.

I don't mind, I trust you to do what's best for these series to be
easily reviewed (if that is at all possible).

The only thing is that this patch implements a feature that will
otherwise be unused, so annotating the functions with __maybe_unused
would avoid warnings.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
