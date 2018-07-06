From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 6 Jul 2018 10:05:36 +0100
Subject: [RFC PATCH 00/16] KVM: arm64: Initial support for SVE guests
In-Reply-To: <87h8lc93jc.fsf@linaro.org>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <87h8lc93jc.fsf@linaro.org>
Message-ID: <20180706090534.GD26019@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 09:22:47AM +0100, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> <snip>
> >
> > This series is somewhat tested on Arm Juno r0 and the Arm Fast Model
> > (with/without SVE support).  arch/arm builds, but I've not booted
> > it -- only some trivial refactoring in this series affects arch/arm.
> 
> Now that QEMU linux-user SVE support is pretty much complete we've also
> got preliminary patches for system emulation mode. However we currently
> don't have VHE implemented so I guess we need to do that first before we
> can test under QEMU.

Qemu can use this as a KVM client without invasive changes, right?

For kvmtool, it's just a question of checking/setting a feature flag
in KVM_ARM_PREFERRED_TARGET and KVM_ARM_VCPU_INIT, and (eventually)
doing at ioctl() to set the set of permitted vector lengths (not yet,
this will come in a follow-up series).

Cheers
---Dave
