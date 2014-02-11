From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Feb 2014 15:11:57 -0600
Subject: [PATCH 7/9] ARM: vt8500: enable V6K instead of plain V6
In-Reply-To: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
Message-ID: <1392153119-23248-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

The wm8750 is an ARM1176 which has all the V6K extensions except for SMP,
so V6K should be selected instead. Dropping the select will use the
default for ARCH_MULTI_V6 which is V6K.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/mach-vt8500/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index c581ed2..08f56a4 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -19,7 +19,6 @@ config ARCH_WM8750
 	bool "WonderMedia WM8750"
 	depends on ARCH_MULTI_V6
 	select ARCH_VT8500
-	select CPU_V6
 	help
 	  Support for WonderMedia WM8750 System-on-Chip.
 
-- 
1.8.3.2
