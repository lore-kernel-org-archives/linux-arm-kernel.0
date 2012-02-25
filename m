From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Sat, 25 Feb 2012 12:55:02 -0700
Subject: [PATCH 1/6] arm: U8500 depends on MMU
Message-ID: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

There is no way to build  U8500 kernels without an MMU
at this point because of dependencies on MMU-only functions.

As long as nobody is interested in fixing this, let's just disable
the platforms for nommu kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a48aecc..f489e52 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -901,6 +901,7 @@ config ARCH_U300
 
 config ARCH_U8500
 	bool "ST-Ericsson U8500 Series"
+	depends on MMU
 	select CPU_V7
 	select ARM_AMBA
 	select GENERIC_CLOCKEVENTS
-- 
1.7.5.4
