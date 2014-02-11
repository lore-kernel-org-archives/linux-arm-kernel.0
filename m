From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Feb 2014 15:11:56 -0600
Subject: [PATCH 6/9] ARM: cns3xxx: enable V6K instead of plain V6
In-Reply-To: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
Message-ID: <1392153119-23248-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

The cns3xxx is an ARM11MPCore which has all the V6K extensions, so V6K
should be selected instead. Dropping the select will use the default for
ARCH_MULTI_V6 which is V6K.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Anton Vorontsov <anton@enomsg.org>
---
 arch/arm/mach-cns3xxx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index b16b29a..dce8dec 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -3,7 +3,6 @@ config ARCH_CNS3XXX
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
-	select CPU_V6
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
-- 
1.8.3.2
