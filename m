From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 19 Dec 2013 15:17:41 +0100
Subject: [PATCH v3 0/2] PSCI system off and reset for KVM ARM/ARM64
In-Reply-To: <20131218203847.GP5711@cbox>
References: <1387280136-13622-1-git-send-email-anup.patel@linaro.org>
 <20131217185154.GN5711@cbox> <87wqj2ql57.fsf@e102391-lin.cambridge.arm.com>
 <CAAhSdy1BenCt+tuBYVR2Kzbrt0Ev59SFG8kaguOwj2Dug7Be4A@mail.gmail.com>
 <87txe6p3o8.fsf@e102391-lin.cambridge.arm.com> <20131218203847.GP5711@cbox>
Message-ID: <52B30005.6060509@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 18/12/2013 21:38, Christoffer Dall ha scritto:
>> > 
>> > So I think we need to:
>> > - Use the new range for PSCI v0.2 (while still supporting v0.1 and the
>> > old range)
>> > - Get the kernel and DT bindings into shape
>> > - Merge all of that at the same time
>> > 
> Don't we also need a way for user space to tell KVM if it should emulate
> v0.1 or v0.2 of PSCI so we don't break backwards compatibility with
> tools that spit out a device tree and use guest kernels based on v0.1?
> 
> This could be a new feature for KVM_ARM_VCPU_INIT, but perhaps it should
> be something on the VM level, hmmm.

You can use KVM_ENABLE_CAP.  It is currently documented as a VCPU ioctl,
but you can reuse it for VMs.  However, it is best if you also add a new
capability KVM_CAP_VM_ENABLE_CAP.  Then rename the old
KVM_CAP_ENABLE_CAP to KVM_CAP_VCPU_ENABLE_CAP, while leaving the old
name for backwards compatibility.

Paolo
