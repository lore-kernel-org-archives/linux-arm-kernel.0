From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 May 2013 17:55:23 +0200
Subject: [PATCHv10 8/9] arm: mvebu: PCIe support is now available on mvebu
In-Reply-To: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1368719725-21265-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the PCIe driver for mvebu has been integrated and all its
relevant dependencies, we can mark the ARCH_MVEBU platform has
MIGHT_HAVE_PCI, which allows to select the PCI bus support if needed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index e11acbb..381062d 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -15,6 +15,8 @@ config ARCH_MVEBU
 	select MVEBU_CLK_GATING
 	select MVEBU_MBUS
 	select ZONE_DMA if ARM_LPAE
+	select MIGHT_HAVE_PCI
+	select PCI_QUIRKS if PCI
 
 if ARCH_MVEBU
 
-- 
1.7.9.5
