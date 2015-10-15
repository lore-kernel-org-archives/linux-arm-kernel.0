From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Oct 2015 14:17:32 +0200
Subject: [PATCH v3 0/4] KVM: arm/arm64: guest synchronous halt/resume
In-Reply-To: <1443217277-13173-1-git-send-email-eric.auger@linaro.org>
References: <1443217277-13173-1-git-send-email-eric.auger@linaro.org>
Message-ID: <20151015121732.GD21930@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 11:41:13PM +0200, Eric Auger wrote:
> This series introduces the capability to synchronously exit the guest
> and prevent it from being re-entered. This modality will be used by
> IRQ forwarding series when changing the state of the IRQ.
> 
> Former pause flag used when starting the vcpu in KVM_ARM_VCPU_POWER_OFF
> state, in PSCI calls and in KVM_SET_MP_STATE ioctl is renamed into
> power_off. A new pause flag is introduced. Both now are checked in
> kvm_arch_vcpu_runnable and in the VCPU_RUN critical section, before
> entering the vcpu.
> 
Thanks - applied,
-Christoffer
