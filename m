From: rric@kernel.org (Robert Richter)
Date: Wed, 30 Jul 2014 17:06:30 +0200
Subject: [PATCH 1/5] arm64,
 thunder: Add Kconfig option for Cavium Thunder SoC Family
In-Reply-To: <1406732794-20920-1-git-send-email-rric@kernel.org>
References: <1406732794-20920-1-git-send-email-rric@kernel.org>
Message-ID: <1406732794-20920-2-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

Increase maximum numbers of cpus to 32. This relates to current
maximal possible cpu number. Increasing this to 64 cpus will be a
separate patch not part of this enablement patches.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a474de346be6..e989d8cab8c7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -128,6 +128,11 @@ source "kernel/Kconfig.freezer"
 
 menu "Platform selection"
 
+config ARCH_THUNDER
+	bool "Cavium Inc. Thunder SoC Family"
+	help
+	  This enables support for Cavium's Thunder Family of SoCs.
+
 config ARCH_VEXPRESS
 	bool "ARMv8 software model (Versatile Express)"
 	select ARCH_REQUIRE_GPIOLIB
@@ -201,6 +206,7 @@ config NR_CPUS
 	range 2 32
 	depends on SMP
 	# These have to remain sorted largest to smallest
+	default "32" if ARCH_THUNDER
 	default "8"
 
 config HOTPLUG_CPU
-- 
2.0.1
