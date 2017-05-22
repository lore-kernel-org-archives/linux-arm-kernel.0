From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 22 May 2017 07:36:04 +0000
Subject: [PATCH 1/2] arm64: disable Broadcom Vulcan platform
In-Reply-To: <1495438565-82495-1-git-send-email-jnair@caviumnetworks.com>
References: <1495438565-82495-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1495438565-82495-2-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the option ARCH_VULCAN as a step towards deleting it entirely.
There is still a reference in the kernel tree for ARCH_VULCAN, so we
have to keep the config option around until that reference is removed.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 arch/arm64/Kconfig.platforms | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 73272f4..fa3715c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -225,10 +225,7 @@ config ARCH_VEXPRESS
 	  Express).
 
 config ARCH_VULCAN
-	bool "Broadcom Vulcan SOC Family"
-	select GPIOLIB
-	help
-	  This enables support for Broadcom Vulcan SoC Family
+	def_bool n
 
 config ARCH_XGENE
 	bool "AppliedMicro X-Gene SOC Family"
-- 
2.7.4
