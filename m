From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue,  6 May 2014 15:12:28 +0100
Subject: [PATCH] arm: Describe required sort order for textofs-y (TEXT_OFFSET)
Message-ID: <1399385548-17892-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The section of the makefile that determines the TEXT_OFFSET is sorted
by address so that, in multi-arch kernel builds, the architecture with the
most stringent requirements for the kernel base address gets to define
TEXT_OFFSET. The comment should reflect that.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 41c1931..6857fec 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -127,6 +127,9 @@ CHECKFLAGS	+= -D__arm__
 
 #Default value
 head-y		:= arch/arm/kernel/head$(MMUEXT).o
+
+# Text offset. This list is sorted numerically by address in order to
+# provide a means to avoid/resolve conflicts in multi-arch kernels.
 textofs-y	:= 0x00008000
 textofs-$(CONFIG_ARCH_CLPS711X) := 0x00028000
 # We don't want the htc bootloader to corrupt kernel during resume
-- 
1.9.0
