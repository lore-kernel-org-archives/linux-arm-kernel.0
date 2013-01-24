From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 24 Jan 2013 15:35:39 +0100
Subject: [kvmarm] [GIT PULL] KVM/ARM core implementation
In-Reply-To: <CANM98qLq5wfuUWHmjn_SHG=f1O9kG_cgwpA2VfOy5y4t0m-52Q@mail.gmail.com>
References: <CANM98qLq5wfuUWHmjn_SHG=f1O9kG_cgwpA2VfOy5y4t0m-52Q@mail.gmail.com>
Message-ID: <6686cc0110a04573c650fc03a0f42017@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Jan 2013 14:22:23 -0500, Christoffer Dall
<c.dall@virtualopensystems.com> wrote:
> Hi Will,
> 
> I've prepared a stable branch for you, for-will/kvm/core, based on
> your stable perf branch.
> 
> Since the last patch series, I've addressed the reviewer comments, and
> rev'ed KVM_CAP_ARM_PSCI to 87, since 86 is already used by PPC in
> kvm/next.
> 
> kvmtool should probably be updated acoordingly.
> 
> I rebased the VGIC and the Arch. Timers series on the stable branch
> and made these available in kvm/vgic and kvm/vgic-timers,
> respectively. These branches are, however, not yet stable.

FWIW, I've now created a kvm-arm/vgic branch, based on for-will/kvm/core
and arm-soc's irqchip/gic-vic-move.

Not much has changed, apart from the obvious include paths and an
additional guard in arm-gic.h. This should definitely be stable now.

The timer code is currently blocked by the lack of a stable branch for the
broadcast stuff.

        M.
-- 
Fast, cheap, reliable. Pick two.
