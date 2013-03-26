From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 17:18:31 +0100
Subject: [PATCHv6 09/17] arm: mvebu: PCIe support is now available on mvebu
In-Reply-To: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1364314719-1049-10-git-send-email-thomas.petazzoni@free-electrons.com>
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
index c3715a5..d353249 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -14,6 +14,8 @@ config ARCH_MVEBU
 	select MVEBU_CLK_CPU
 	select MVEBU_CLK_GATING
 	select MVEBU_MBUS
+	select MIGHT_HAVE_PCI
+	select PCI_QUIRKS if PCI
 
 if ARCH_MVEBU
 
-- 
1.7.9.5
