From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 04 Sep 2015 16:35:20 +0100
Subject: [PATCH 0/2] arm/arm64: KVM: Fix arthictected timer issues
In-Reply-To: <1441376679-8341-1-git-send-email-christoffer.dall@linaro.org>
References: <1441376679-8341-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <55E9BA38.7030305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 04/09/15 15:24, Christoffer Dall wrote:
> These two patches fix two separate issues with the architected timer and
> the corresponding interrupt injection to VMs on KVM/ARM.
> 
> The first patch fixes an issue introduced with the active timer state
> switching series recently merged for v4.3, which could cause a guest to
> loop without progress if another VCPU is run on the same physical CPU
> and preempts the original VCPU while the guest is running the ISR for
> the timer interrupt.
> 
> The second patch resets the architected timer's control register to zero
> on system reset, ensuring that interrupts are not injected when a system
> resets.  This fixes a long-standing issue with UEFI, where soft reset
> initiated from within UEFI prevented the system from booting again.

Thanks for respinning these patches. I've queued them in our -next
queue. I'll send this to Paolo some time next week, once they get some
hammering.

	M.
-- 
Jazz is not dead. It just smells funny...
