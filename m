From: alan@signal11.us (Alan Ott)
Date: Thu,  1 Mar 2012 14:26:47 -0500
Subject: [PATCH 5/8] ARM: tegra: work around tegra THUMB2_KERNEL bug
In-Reply-To: <1330630010-11241-1-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
Message-ID: <1330630010-11241-6-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The tegra smp code cannot currently be built for t2, so
disable that combination for now, as a workaround.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a48aecc..ea1d59b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1598,6 +1598,7 @@ config HZ
 config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode (EXPERIMENTAL)"
 	depends on CPU_V7 && !CPU_V6 && !CPU_V6K && EXPERIMENTAL
+	depends on !SMP || !ARCH_TEGRA
 	select AEABI
 	select ARM_ASM_UNIFIED
 	select ARM_UNWIND
-- 
1.7.0.4
