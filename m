From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Mon, 31 Mar 2014 10:07:37 +0900
Subject: [PATCH,RESEND] arm: Do not define "comma" twice
Message-ID: <1396228057-1488-1-git-send-email-yamada.m@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have the definition of "comma" in scripts/Kbuild.include.
We should not double it.

Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
---

First I posted this patch to linux-kbuild ML.
But, Michal Marek recommended me to send it to linux-arm-kernel ML.

So this is here now.


 arch/arm/Makefile   | 2 --
 arch/arm64/Makefile | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 08a9ef5..72f7b8c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -50,8 +50,6 @@ AS		+= -EL
 LD		+= -EL
 endif
 
-comma = ,
-
 # This selects which instruction set is used.
 # Note that GCC does not numerically define an architecture version
 # macro, but instead defines a whole series of macros which makes
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2fceb71..473a050 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -30,8 +30,6 @@ AS		+= -EL
 LD		+= -EL
 endif
 
-comma = ,
-
 CHECKFLAGS	+= -D__aarch64__
 
 # Default value
-- 
1.8.3.2
