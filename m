From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 23 Apr 2012 14:31:53 +0200
Subject: [PATCH] ARM: optimize for FA526 if toolchain supports it
Message-ID: <1335184313-27573-1-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when we are targetting a Farady FA526-based system
the toolchain will use the arm9tdmi mtune option of gcc, gcc > 4.6
supports the FA526 CPU, and allow us to optimize for it.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/arm/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 047a207..5b0eafe 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -82,7 +82,7 @@ tune-$(CONFIG_CPU_ARM920T)	:=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_ARM922T)	:=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_ARM925T)	:=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_ARM926T)	:=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_FA526)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_FA526)	:=$(call cc-option,-mtune=fa526,-mtune=arm9tdmi)
 tune-$(CONFIG_CPU_SA110)	:=-mtune=strongarm110
 tune-$(CONFIG_CPU_SA1100)	:=-mtune=strongarm1100
 tune-$(CONFIG_CPU_XSCALE)	:=$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-mcpu=xscale
-- 
1.7.5.4
