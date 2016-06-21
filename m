From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 21 Jun 2016 12:01:31 -0500
Subject: [PATCH 0/2] ARM/PCI: Make I/O port space optional
Message-ID: <20160621165646.7997.44001.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we always require an I/O port resource for PCI host bridges.  Even
if the bridge doesn't actually support I/O port space, we add a default I/O
resource for it.

These patches make I/O port space optional on ARM.  Comments welcome.

If these look OK, I'll fold them into the series at [1], where they should
fix a resource conflict [2] in the R-Car driver.

[1] http://lkml.kernel.org/r/20160606225630.20936.77349.stgit at bhelgaas-glaptop2.roam.corp.google.com
[2] http://lkml.kernel.org/r/CAMuHMdVgLfTD-BjRZ+gVKgYE8dkDZzQ6DnYtkUs+jVPthJsEdQ at mail.gmail.com

---

Bjorn Helgaas (2):
      ARM: Make PCI I/O space optional
      PCI: rcar: Drop gen2 dummy I/O port region


 arch/arm/include/asm/mach/pci.h  |    1 +
 arch/arm/kernel/bios32.c         |   13 +++++++++++--
 drivers/pci/host/pci-rcar-gen2.c |   11 +----------
 3 files changed, 13 insertions(+), 12 deletions(-)
