From: stefan@agner.ch (Stefan Agner)
Date: Wed, 21 Mar 2018 00:02:05 +0100
Subject: [PATCH 4/5] ARM: drop no-thumb-interwork in EABI mode
In-Reply-To: <20180320230206.25289-1-stefan@agner.ch>
References: <20180320230206.25289-1-stefan@agner.ch>
Message-ID: <20180320230206.25289-5-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to GCC documentation -m(no-)thumb-interwork is
meaningless in AAPCS configurations. Also clang does not
support the flag:
  clang-5.0: error: unknown argument: '-mno-thumb-interwork'

Just drop -mno-thumb-interwork in AEABI configuration.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e83f5161fdd8..e9e3fde3c657 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -106,7 +106,7 @@ tune-$(CONFIG_CPU_V6K)		=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
 tune-y := $(tune-y)
 
 ifeq ($(CONFIG_AEABI),y)
-CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp
+CFLAGS_ABI	:=-mabi=aapcs-linux -mfpu=vfp
 else
 CFLAGS_ABI	:=$(call cc-option,-mapcs-32,-mabi=apcs-gnu) $(call cc-option,-mno-thumb-interwork,)
 endif
-- 
2.16.2
