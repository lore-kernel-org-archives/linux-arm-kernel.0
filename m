From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 28 Aug 2018 16:05:11 +0100
Subject: [PATCH 0/2] Drop node-local allocation during host controller
 initialisation
Message-ID: <20180828150513.32458-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

As discussed before[0], here are a couple of patches to drop
node-local allocations during host contoller initialisation. This set
covers both arm64 and x86.

I'm posting early to give the patches time on the list as well in next
in case there are issues we've missed.

The patches are based on v4.19-rc1 and has been boot tested on arm64
and compile tested on x86.

Thanks,
Punit

[0] https://www.spinics.net/lists/arm-kernel/msg669746.html

Punit Agrawal (2):
  arm64: PCI: Remove node-local allocations when initialising host
    controller
  x86/PCI: Remove node-local allocation when initialising host
    controller

 arch/arm64/kernel/pci.c | 5 ++---
 arch/x86/pci/acpi.c     | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.18.0
