From: fkan@apm.com (Feng Kan)
Date: Wed,  7 May 2014 09:18:04 -0700
Subject: [PATCH V6 5/5] arm64: Select reboot driver for X-Gene platform
In-Reply-To: <1399479484-2605-1-git-send-email-fkan@apm.com>
References: <1399479484-2605-1-git-send-email-fkan@apm.com>
Message-ID: <1399479484-2605-6-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select reboot driver for X-Gene platform.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9711a5f..007f340 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -129,6 +129,8 @@ config ARCH_VEXPRESS
 
 config ARCH_XGENE
 	bool "AppliedMicro X-Gene SOC Family"
+	select MFD_SYSCON
+	select POWER_RESET_SYSCON
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
-- 
1.7.6.1
