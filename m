From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:19 +0100
Subject: [PATCH 13/14] arm64: kconfig: allow CPU_BIG_ENDIAN to be selected
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-14-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

This patch wires up CONFIG_CPU_BIG_ENDIAN for the AArch64 kernel
configuration.

Selecting this option builds a big-endian kernel which can boot into a
big-endian userspace.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c044548..95d6cb9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -138,6 +138,11 @@ config ARM64_64K_PAGES
 	  look-up. AArch32 emulation is not available when this feature
 	  is enabled.
 
+config CPU_BIG_ENDIAN
+       bool "Build big-endian kernel"
+       help
+         Say Y if you plan on running a kernel in big-endian mode.
+
 config SMP
 	bool "Symmetric Multi-Processing"
 	select USE_GENERIC_SMP_HELPERS
-- 
1.7.9.5
