From: jnair@caviumnetworks.com (Jayachandran C)
Date: Tue, 7 Feb 2017 21:19:55 +0000
Subject: [PATCH v3 1/5] arm64: add THUNDER2 processor family
In-Reply-To: <1486502399-2950-1-git-send-email-jnair@caviumnetworks.com>
References: <1486502399-2950-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1486502399-2950-2-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for ThunderX2 CN99XX arm64 server processors. Introduce a
new arm64 platform config option ARCH_THUNDER2 for these processors.

ARCH_THUNDER2 has the same on-chip devices as ARCH_VULCAN, so select
ARCH_VULCAN for now, until the driver dependencies are updated.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 arch/arm64/Kconfig.platforms | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 715ef12..1ee377d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -190,6 +190,14 @@ config ARCH_THUNDER
 	help
 	  This enables support for Cavium's Thunder Family of SoCs.
 
+config ARCH_THUNDER2
+	bool "Cavium ThunderX2 Server Processors"
+	select ARCH_VULCAN
+	select GPIOLIB
+	help
+	  This enables support for Cavium's ThunderX2 CN99XX family of
+	  server processors.
+
 config ARCH_UNIPHIER
 	bool "Socionext UniPhier SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
-- 
2.7.4
