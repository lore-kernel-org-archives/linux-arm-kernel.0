From: pebolle@tiscali.nl (Paul Bolle)
Date: Sat, 13 Jul 2013 22:09:51 +0200
Subject: [PATCH] ARM: multiplatform: remove reference to ARCH_MULTI_V4
Message-ID: <1373746191.1359.37.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol ARCH_MULTI_V4 was removed in commit 24e860fbfd
("ARM: multiplatform: always pick one CPU type"). Remove the last
reference to it too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Untested.

1) Commit 24e860fbfd is silent on the reason to drop ARCH_MULTI_V4. And
the ARM section of the Kconfig files is rather complicated for people,
like me, that aren't familiar with the way the ARM universe is divided
in architectures, machines, platforms, etc. That makes it hard to say
whether ARCH_MULTI_V4 was dropped on purpose or by accident.

 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0ac9be6..0746bc8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -912,7 +912,7 @@ config ARCH_MULTI_V6_V7
 	bool
 
 config ARCH_MULTI_CPU_AUTO
-	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
+	def_bool !(ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
 	select ARCH_MULTI_V5
 
 endmenu
-- 
1.8.1.4
