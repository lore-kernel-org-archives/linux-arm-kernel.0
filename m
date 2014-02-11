From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Feb 2014 15:11:59 -0600
Subject: [PATCH 9/9] ARM: virt: select ARM_AMBA
In-Reply-To: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
Message-ID: <1392153119-23248-10-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Guests can use AMBA bus devices such as the PL011 uart, so enable the
AMBA bus for mach-virt.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9790c5d..25a6b53 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -931,9 +931,10 @@ endmenu
 
 config ARCH_VIRT
 	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
+	select ARM_AMBA
 	select ARM_GIC
-	select HAVE_ARM_ARCH_TIMER
 	select ARM_PSCI
+	select HAVE_ARM_ARCH_TIMER
 
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
-- 
1.8.3.2
