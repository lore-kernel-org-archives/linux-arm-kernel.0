From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Apr 2011 10:21:07 +0100
Subject: [PATCH 2/2] ARM: Only allow PM_SLEEP with CPUs which support suspend
In-Reply-To: <20110402091904.GH8482@n2100.arm.linux.org.uk>
References: <20110402091904.GH8482@n2100.arm.linux.org.uk>
Message-ID: <E1Q5x11-0001Z0-45@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Offering CONFIG_PM_SLEEP for CPUs which do not support suspend leads to
build errors, so only set CONFIG_ARCH_SUSPEND_POSSIBLE if we have a CPU
selected which supports suspend.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b9f78b..9954c9b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2012,6 +2012,8 @@ source "kernel/power/Kconfig"
 
 config ARCH_SUSPEND_POSSIBLE
 	depends on !ARCH_S5P64X0 && !ARCH_S5P6442
+	depends on CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || \
+		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE
 	def_bool y
 
 endmenu
-- 
1.7.4
