From: tixy@yxit.co.uk (Tixy)
Date: Mon, 29 Aug 2011 13:34:00 +0100
Subject: [PATCH 01/10] ARM: kprobes: Add config option for selecting the ARM
	kprobes tests
In-Reply-To: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
References: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1314621249-958-2-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/Kconfig.debug |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 81cbe40..8f95417 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -129,4 +129,14 @@ config DEBUG_S3C_UART
 	  The uncompressor code port configuration is now handled
 	  by CONFIG_S3C_LOWLEVEL_UART_PORT.
 
+config ARM_KPROBES_TESTS
+	bool
+
+config ARM_KPROBES_TEST_MODULE
+	tristate "Kprobes test module"
+	depends on KPROBES && MODULES
+	select ARM_KPROBES_TESTS
+	help
+	  "Perform tests of kprobes API and instruction set simulation"
+
 endmenu
-- 
1.7.2.5
