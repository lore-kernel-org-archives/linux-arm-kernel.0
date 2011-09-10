From: tixy@yxit.co.uk (Tixy)
Date: Sat, 10 Sep 2011 12:04:57 +0100
Subject: [PATCH v2 01/10] ARM: kprobes: Add config option for selecting the
	ARM kprobes tests
In-Reply-To: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
References: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1315652706-2900-2-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/Kconfig.debug |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 81cbe40..be3a0f7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -129,4 +129,10 @@ config DEBUG_S3C_UART
 	  The uncompressor code port configuration is now handled
 	  by CONFIG_S3C_LOWLEVEL_UART_PORT.
 
+config ARM_KPROBES_TEST
+	tristate "Kprobes test module"
+	depends on KPROBES && MODULES
+	help
+	  Perform tests of kprobes API and instruction set simulation.
+
 endmenu
-- 
1.7.2.5
