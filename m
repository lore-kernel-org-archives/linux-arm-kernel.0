From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 25 Jun 2015 07:33:46 +0100
Subject: [PATCH v6 00/12] KVM Guest Debug support for arm64
In-Reply-To: <20150624201915.GC22785@cbox>
References: <1434716630-18260-1-git-send-email-alex.bennee@linaro.org>
 <20150624201915.GC22785@cbox>
Message-ID: <87pp4kxpo5.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Christoffer Dall <christoffer.dall@linaro.org> writes:

> On Fri, Jun 19, 2015 at 01:23:38PM +0100, Alex Benn?e wrote:
>> Here is V6 of the KVM Guest Debug support for arm64.
>> 
>> The changes are even more minimal than the last round which is
>> hopefully a good indication the series is ready for merging:
>> 
> Unfortunately this series breaks the build on 32-bit ARM:

I'll get on those today.

>
>
> /home/christoffer/src/kvmarm/arm64/linux-kvm-arm/arch/arm/kvm/arm.c: In function ?kvm_arch_vcpu_init?:
> /home/christoffer/src/kvmarm/arm64/linux-kvm-arm/arch/arm/kvm/arm.c:283:12: error: ?struct kvm_vcpu_arch? has no member named ?debug_ptr?
>   vcpu->arch.debug_ptr = &vcpu->arch.vcpu_debug_state;
>             ^
> /home/christoffer/src/kvmarm/arm64/linux-kvm-arm/arch/arm/kvm/arm.c:283:36: error: ?struct kvm_vcpu_arch? has no member named ?vcpu_debug_state?
>   vcpu->arch.debug_ptr = &vcpu->arch.vcpu_debug_state;
>                                     ^
> /home/christoffer/src/kvmarm/arm64/linux-kvm-arm/arch/arm/kvm/arm.c: In function ?kvm_arch_vcpu_ioctl_set_guest_debug?:
> /home/christoffer/src/kvmarm/arm64/linux-kvm-arm/arch/arm/kvm/arm.c:309:8: error: ?KVM_GUESTDBG_USE_SW_BP? undeclared (first use in this function)
>         KVM_GUESTDBG_USE_SW_BP | \
>         ^
> /home/christoffer/src/kvmarm/arm64/linux-kvm-arm/arch/arm/kvm/arm.c:328:22: note: in expansion of macro ?KVM_GUESTDBG_VALID_MASK?
>   if (dbg->control & ~KVM_GUESTDBG_VALID_MASK)
>                       ^
> /home/christoffer/src/kvmarm/arm64/linux-kvm-arm/arch/arm/kvm/arm.c:309:8: note: each undeclared identifier is reported only once for each function it appears in
>         KVM_GUESTDBG_USE_SW_BP | \
>         ^
> /home/christoffer/src/kvmarm/arm64/linux-kvm-arm/arch/arm/kvm/arm.c:328:22: note: in expansion of macro ?KVM_GUESTDBG_VALID_MASK?
>   if (dbg->control & ~KVM_GUESTDBG_VALID_MASK)
>                       ^
> /home/christoffer/src/kvmarm/arm64/linux-kvm-arm/arch/arm/kvm/arm.c:310:8: error: ?KVM_GUESTDBG_USE_HW? undeclared (first use in this function)
>         KVM_GUESTDBG_USE_HW | \
>         ^
> /home/christoffer/src/kvmarm/arm64/linux-kvm-arm/arch/arm/kvm/arm.c:328:22: note: in expansion of macro ?KVM_GUESTDBG_VALID_MASK?
>   if (dbg->control & ~KVM_GUESTDBG_VALID_MASK)
>                       ^
> /home/christoffer/src/kvmarm/arm64/linux-kvm-arm/arch/arm/kvm/arm.c:336:14: error: ?struct kvm_vcpu_arch? has no member named ?external_debug_state?
>     vcpu->arch.external_debug_state = dbg->arch;
>               ^
> make[2]: *** [arch/arm/kvm/arm.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [arch/arm/kvm] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2
>
>
> -Christoffer

-- 
Alex Benn?e
