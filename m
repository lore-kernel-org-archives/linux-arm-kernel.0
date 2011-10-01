From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:51 +0200
Subject: [PATCH 19/26] ARM: pxa: CPU_FREQ_TABLE is needed for CPU_FREQ
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-20-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa specific cpufreq code is based on the cpu_freq_table
module, so we have to select that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 71b0ccb..3b84eda 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1926,6 +1926,7 @@ config CPU_FREQ_PXA
 	bool
 	depends on CPU_FREQ && ARCH_PXA && PXA25x
 	default y
+	select CPU_FREQ_TABLE
 	select CPU_FREQ_DEFAULT_GOV_USERSPACE
 
 config CPU_FREQ_S3C
-- 
1.7.5.4
