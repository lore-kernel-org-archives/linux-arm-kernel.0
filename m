From: fkan@apm.com (Feng Kan)
Date: Tue, 14 Jan 2014 17:07:34 -0800
Subject: [PATCH V3 2/3] arm64: Enable system reset via arch Kconfig for X-Gene
 system.
In-Reply-To: <1389748055-23534-1-git-send-email-fkan@apm.com>
References: <1389748055-23534-1-git-send-email-fkan@apm.com>
Message-ID: <1389748055-23534-3-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select X-Gene reboot driver for X-Gene platform.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 249acb9..bfdf029 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -122,6 +122,8 @@ config ARCH_VEXPRESS
 
 config ARCH_XGENE
 	bool "AppliedMicro X-Gene SOC Family"
+	select POWER_RESET_XGENE
+	select MFD_SYSCON
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
-- 
1.7.6.1
