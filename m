From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 04 Jun 2013 13:29:34 +0100
Subject: Planning the merge of KVM/arm64
Message-ID: <51ADDDAE.4040705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

The KVM/arm64 code is now, as it seems, in good enough shape to be
merged. I've so far addressed all the comments, and it doesn't seem any
worse then what is queued for its 32bit counterpart.

For reference, it is sitting there:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
kvm-arm64/kvm

What is not defined yet is the merge path:
- It is touching some of the arm64 core code, so it would be better if
it was merged through the arm64 tree
- It is depending on some of the patches in the core KVM queue (the
vgic/timer move to virt/kvm/arm/)
- It is also depending on some of the patches that are in the KVM/ARM
queue (parametrized timer interrupt, some MMU/MMIO fixes)

So I can see two possibilities:
- Either I can rely on a stable branch from both KVM and KVM/ARM trees
on which I can base my tree for Catalin/Will to pull,
- Or I ask Catalin to only pull the arm64 part *minus the Kconfig*, and
only merge this last bit when the dependencies are satisfied in Linus' tree.

What do you guys think?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
