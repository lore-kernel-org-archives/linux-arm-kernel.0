From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:17:57 +0100
Subject: [PATCH 1/5] ARM: add CPU_BE8_BOOT_LE configuration
In-Reply-To: <1377890281-10757-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377890281-10757-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377890281-10757-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add configuration for booting a BE8 system from a LE boot environment.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mm/Kconfig |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 1f8fed9..8b89ca1 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -712,6 +712,13 @@ config CPU_ENDIAN_BE8
 	help
 	  Support for the BE-8 (big-endian) mode on ARMv6 and ARMv7 processors.
 
+config CPU_BE8_BOOT_LE
+	bool "Boot BE system from LE loader"
+	depends on CPU_ENDIAN_BE8
+	help
+	  Support for running BE-8 (big-endian) from a boot environment that is
+	  running in LE mode.
+
 config CPU_ENDIAN_BE32
 	bool
 	depends on CPU_BIG_ENDIAN
-- 
1.7.10.4
