From: rric@kernel.org (Robert Richter)
Date: Wed, 24 Sep 2014 17:37:48 +0200
Subject: [PATCH 6/6] pci, thunder: Enable Cavium Thunder PCIe host controller
In-Reply-To: <1411573068-12952-1-git-send-email-rric@kernel.org>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
Message-ID: <1411573068-12952-7-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

Enable Cavium Thunder PCIe host controller driver.

IOV is enabled per default if drivers with IOV support are
enabled. IOV can be disabled.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 97777e1ef5a7..bd9724e5c8a1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -172,6 +172,14 @@ config PCI
 config PCI_MSI
 	def_bool PCI
 
+config NO_PCI_IOV
+	def_bool PCI
+	depends on !PCI_THUNDER
+
+config PCI_IOV
+	def_bool PCI
+	depends on !NO_PCI_IOV
+
 config PCI_DOMAINS
 	def_bool PCI
 
@@ -185,6 +193,9 @@ source "drivers/pci/Kconfig"
 source "drivers/pci/pcie/Kconfig"
 source "drivers/pci/hotplug/Kconfig"
 
+config PCI_THUNDER
+	def_bool PCI
+
 endmenu
 
 menu "Kernel Features"
-- 
2.1.0
