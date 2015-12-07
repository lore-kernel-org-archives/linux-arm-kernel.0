From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  7 Dec 2015 10:11:10 +0000
Subject: [PATCH 0/2] irqchip/gic-v3: Small cleanups for 4.4
Message-ID: <1449483072-17694-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, Jason,

I've been sitting on a couple of one-liners that affect GICv3. Nothing
dramatic (and certainly nothing that affects mainline today), but they
do get in the way of a KVM/ARM series that is aimed at 4.5 [1], and
I'd like to make sure we don't have too many ordering issues.

Alternatively, I can either carry these patches (with some Acks), or
rebase the KVM/ARM stuff on a stable branch (but that seems a bit
overkill for such a small set of changes).

Thanks,

	M.

[1] https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/wsinc

Marc Zyngier (2):
  irqchip/gic-v3: Add missing struct device_node declaration
  irqchip/gic-v3: Add missing include for barrier.h

 arch/arm/include/asm/arch_gicv3.h   | 1 +
 arch/arm64/include/asm/arch_gicv3.h | 1 +
 include/linux/irqchip/arm-gic-v3.h  | 1 +
 3 files changed, 3 insertions(+)

-- 
2.1.4
