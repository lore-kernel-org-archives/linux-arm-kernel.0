From: fkan@apm.com (Feng Kan)
Date: Thu, 23 Jan 2014 11:20:00 -0800
Subject: [PATCH V4 4/5] arm64: Select reboot driver for X-Gene platform
In-Reply-To: <1390504801-24483-1-git-send-email-fkan@apm.com>
References: <1390504801-24483-1-git-send-email-fkan@apm.com>
Message-ID: <1390504801-24483-5-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select reboot driver for X-Gene platform.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dd4327f..f43820f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -123,6 +123,8 @@ config ARCH_VEXPRESS
 
 config ARCH_XGENE
 	bool "AppliedMicro X-Gene SOC Family"
+	select MFD_SYSCON
+	select POWER_RESET_SYSCON
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
-- 
1.7.6.1
