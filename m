From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:56 +0200
Subject: [PATCH 24/26] ARM: pxa: centro and treo680 need palm27x
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-25-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two platforms are part of the palm27x family and use the same
code. Select the palm27x symbol to make sure they can be built
standalone.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 568b7f6..da6fca0 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -431,6 +431,7 @@ config MACH_CENTRO
 	bool "Palm Centro 685 (GSM)"
 	default y
 	depends on ARCH_PXA_PALM
+	select MACH_PALM27X
 	select PXA27x
 	select IWMMXT
 	select PALM_TREO
@@ -442,6 +443,7 @@ config MACH_TREO680
 	bool "Palm Treo 680"
 	default y
 	depends on ARCH_PXA_PALM
+	select MACH_PALM27X
 	select PXA27x
 	select IWMMXT
 	select PALM_TREO
-- 
1.7.5.4
