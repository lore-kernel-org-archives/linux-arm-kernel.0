From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:33 -0800
Subject: [RFC 14/18] arm: msm: add v7 support for compiler version-4.1.1
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-15-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Taniya Das <tdas@qualcomm.com>

Signed-off-by: Taniya Das <tdas@qualcomm.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/Makefile |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e9da084..aa32b39 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -50,7 +50,13 @@ comma = ,
 # Note that GCC does not numerically define an architecture version
 # macro, but instead defines a whole series of macros which makes
 # testing for a specific architecture or later rather impossible.
-arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7-a)
+CONFIG_SHELL	:=/bin/sh
+GCC_VERSION	:= $(shell $(CONFIG_SHELL) $(PWD)/scripts/gcc-version.sh $(CROSS_COMPILE)gcc)
+ifeq ($(GCC_VERSION),0401)
+arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7a,-march=armv5t -Wa$(comma)-march=armv7a)
+else
+arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7a)
+endif
 arch-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6,-march=armv5t -Wa$(comma)-march=armv6)
 # Only override the compiler option if ARMv6. The ARMv6K extensions are
 # always available in ARMv7
-- 
1.6.3.3
