From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:34 +0000
Subject: [PATCH 04/17] ARM: Add ARCH_SUPPORTS_BIG_ENDIAN
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360365467-25056-5-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARCH_SUPPORTS_BIG_ENDIAN define to arch/arm/Kconfig. Since it used
to live in arch/arm/mach-ixp4xx/Kconfig we move it up to the ARM one
as the next best place for it.

It may be that it could be moved to a more generic location, with the
other ARCH_SUPPORT functions.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/Kconfig |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d3f6c4f..8dfa634 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -152,6 +152,12 @@ config ARCH_HAS_CPUFREQ
 	  and that the relevant menu configurations are displayed for
 	  it.
 
+config ARCH_SUPPORTS_BIG_ENDIAN
+	bool
+	help
+	  Internal node to specify the architecture can run in Big Endian
+	  mode.
+
 config GENERIC_HWEIGHT
 	bool
 	default y
-- 
1.7.10.4
