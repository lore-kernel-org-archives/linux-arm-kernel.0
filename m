From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 14 Nov 2013 14:37:40 -0500
Subject: [PATCH 0/6] ARM/AMR64: Few patches on kvm and mm code
In-Reply-To: <y>
References: <y>
Message-ID: <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While playing with KVM on Keystone, I came across few issues which needs
to be addressed. Have discussed most of these with Marc and Christoffer
off-list but we all thought of getting these patchset on list for wider
review.

At least virt_addr_valid() update am not sure and would like
to get discussion going on how to proceed with it. The last patch
in the series is a hack and included in the series to get some
tips.

Special thanks to Christoffer and Marc for their support in figuring
out these issues.

Generated against tip of Linus's tree(4fbf888) which includes 
__virt_to_idmap() and related patchset.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>

Santosh Shilimkar (6):
  arm64: mm: Add __virt_to_idmap() to keep kvm build happy
  ARM: kvm: Use virt_to_idmap instead of virt_to_phys for idmap
    mappings
  ARM: mm: Drop the lowmem watermark check from virt_addr_valid()
  arm64: mm: Drop the lowmem watermark check from virt_addr_valid()
  ARM: kvm: Use phys_addr_t instead of unsigned long in mm code
  ARM: kvm: TMP: Commit the hyp page tables to main memory

 arch/arm/include/asm/memory.h   |    3 +--
 arch/arm/kvm/mmu.c              |   12 ++++++------
 arch/arm64/include/asm/memory.h |   11 +++++++++--
 3 files changed, 16 insertions(+), 10 deletions(-)

-- 
1.7.9.5
