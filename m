From: fkan@apm.com (Feng Kan)
Date: Thu, 31 Jul 2014 19:45:56 -0700
Subject: [PATCH V9 5/6] arm64: Select reboot driver for X-Gene platform
In-Reply-To: <1406861157-29169-1-git-send-email-fkan@apm.com>
References: <1406861157-29169-1-git-send-email-fkan@apm.com>
Message-ID: <1406861157-29169-6-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select reboot driver for X-Gene platform.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 839f48c..df6a646 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -141,6 +141,8 @@ config ARCH_VEXPRESS
 
 config ARCH_XGENE
 	bool "AppliedMicro X-Gene SOC Family"
+	select MFD_SYSCON
+	select POWER_RESET_SYSCON
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
-- 
1.9.1
