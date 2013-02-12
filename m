From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 17:28:56 +0100
Subject: [PATCH 22/32] arm: plat-orion: make common PCIe code usable on mvebu
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1360686546-24277-23-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mvebu is a new-style Orion platform, so it only selects PLAT_ORION,
but not PLAT_ORION_LEGACY. It will however need the common PCIe code
from plat-orion, so make this code available for PLAT_ORION platforms
as a whole, and not only PLAT_ORION_LEGACY platforms.

We also take this opportunity to build the PCIe code only when
CONFIG_PCI is enabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index a82cecb..1aca22b 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -4,7 +4,8 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
 obj-y                             += addr-map.o
+obj-$(CONFIG_PCI)                 += pcie.o
 
 orion-gpio-$(CONFIG_GENERIC_GPIO) += gpio.o
-obj-$(CONFIG_PLAT_ORION_LEGACY)   += irq.o pcie.o time.o common.o mpp.o
+obj-$(CONFIG_PLAT_ORION_LEGACY)   += irq.o time.o common.o mpp.o
 obj-$(CONFIG_PLAT_ORION_LEGACY)   += $(orion-gpio-y)
-- 
1.7.9.5
