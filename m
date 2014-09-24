From: rric@kernel.org (Robert Richter)
Date: Wed, 24 Sep 2014 17:37:47 +0200
Subject: [PATCH 5/6] arm64, defconfig: Enable PCI
In-Reply-To: <1411573068-12952-1-git-send-email-rric@kernel.org>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
Message-ID: <1411573068-12952-6-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

Enable the PCI subsystem in defconfig. There will be more and more
systems with pci support, so default enable it. This also implicitly
enables the MSI feature.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ca3f7e9afd4d..97777e1ef5a7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -163,11 +163,15 @@ config ARM_AMBA
 
 config PCI
 	bool "PCI support"
+	default y
 	help
 	  This feature enables support for PCIe bus system. If you say Y
 	  here, the kernel will include drivers and infrastructure code
 	  to support PCIe bus devices.
 
+config PCI_MSI
+	def_bool PCI
+
 config PCI_DOMAINS
 	def_bool PCI
 
-- 
2.1.0
