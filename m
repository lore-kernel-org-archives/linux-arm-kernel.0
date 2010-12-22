From: colin.tuckley@arm.com (Colin Tuckley)
Date: Wed, 22 Dec 2010 14:03:58 +0000
Subject: [PATCH 1/6] ARM: enable bridges in pci_common_init.
In-Reply-To: <20101222140305.29725.50845.stgit@e102602-lin.cambridge.arm.com>
References: <20101222140305.29725.50845.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20101222140358.29725.85551.stgit@e102602-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a missing call to pci_enable_bridges() so that devices behind
bridges get found by the pci bus scan.

Signed-off-by: Chris Partington <chris.partington@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/arm/kernel/bios32.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index c6273a3..d86fcd4 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -583,6 +583,11 @@ void __init pci_common_init(struct hw_pci *hw)
 			 * Assign resources.
 			 */
 			pci_bus_assign_resources(bus);
+
+			/*
+			 * Enable bridges
+			 */
+			pci_enable_bridges(bus);
 		}
 
 		/*
