From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Jan 2015 19:42:11 +0100
Subject: [PATCH 2/7] ARM: at91: remove useless config MACH_AT91RM9200_DT
In-Reply-To: <1421088136-10172-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421088136-10172-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421088136-10172-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that rm9200 is only supported through DT, remove CONFIG_MACH_AT91RM9200_DT
and use CONFIG_SOC_AT91RM9200 instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig  | 3 ---
 arch/arm/mach-at91/Makefile | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 2395c68b3e32..34725b296e4d 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -174,9 +174,6 @@ config SOC_AT91SAM9N12
 # ----------------------------------------------------------
 endif # SOC_SAM_V4_V5
 
-config MACH_AT91RM9200_DT
-	def_bool SOC_AT91RM9200
-
 config MACH_AT91SAM9_DT
 	def_bool SOC_AT91SAM9
 
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 7b6424d40764..55fc93f5638b 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_SOC_SAMA5D3)	+= sama5d3.o
 obj-$(CONFIG_SOC_SAMA5D4)	+= sama5d4.o
 
 # AT91SAM board with device-tree
-obj-$(CONFIG_MACH_AT91RM9200_DT) += board-dt-rm9200.o
+obj-$(CONFIG_SOC_AT91RM9200) += board-dt-rm9200.o
 obj-$(CONFIG_MACH_AT91SAM9_DT) += board-dt-sam9.o
 
 # SAMA5 board with device-tree
-- 
2.1.0
