From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 20 May 2014 20:43:50 +0400
Subject: [PATCH] ARM: i.MX: Compile FIQ code for AVIC & TZIC only
In-Reply-To: <1400604231-2672-1-git-send-email-shc_work@mail.ru>
References: <1400604231-2672-1-git-send-email-shc_work@mail.ru>
Message-ID: <1400604231-2672-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no reason to compile FIQ specific code for GIC IRQ
controller (i.MX6). This patch restrict compilation for FIQ
specific code for AVIC and TZIC only.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index bbe93bb..620a760 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,4 +1,4 @@
-obj-y := time.o cpu.o system.o irq-common.o
+obj-y := time.o cpu.o system.o
 
 obj-$(CONFIG_SOC_IMX1) += clk-imx1.o mm-imx1.o
 obj-$(CONFIG_SOC_IMX21) += clk-imx21.o mm-imx21.o
@@ -21,8 +21,8 @@ obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
 obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 
-obj-$(CONFIG_MXC_TZIC) += tzic.o
-obj-$(CONFIG_MXC_AVIC) += avic.o
+obj-$(CONFIG_MXC_TZIC) += tzic.o irq-common.o
+obj-$(CONFIG_MXC_AVIC) += avic.o irq-common.o
 
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
-- 
1.8.5.5
