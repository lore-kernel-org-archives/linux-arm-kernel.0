From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 25 Mar 2015 11:27:48 +0000
Subject: [PATCH RESEND 3/7] ARM: socfpga: support big endian for socfpga
In-Reply-To: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427282872-10563-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the debug and platsmp.S are fixed for big endian, the
architecture can now advertise big endian support.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
CC: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/mach-socfpga/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index b5f8d75..f420a1b 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_SOCFPGA
 	bool "Altera SOCFPGA family" if ARCH_MULTI_V7
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
 	select CACHE_L2X0
-- 
2.1.4
