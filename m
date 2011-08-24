From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 08:46:39 +0200
Subject: [PATCH 1/2] ARM i.MX: remove ARCH_MX* macros from Makefile
In-Reply-To: <1314168400-14889-1-git-send-email-s.hauer@pengutronix.de>
References: <1314168400-14889-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314168400-14889-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are scheduled for removal and replaced by CONFIG_SOC_IMX*
macros where appropriate.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Makefile |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index e9eb36d..db6394a 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,12 +1,12 @@
 obj-$(CONFIG_IMX_HAVE_DMA_V1) += dma-v1.o
 
-obj-$(CONFIG_ARCH_MX1) += clock-imx1.o mm-imx1.o
-obj-$(CONFIG_MACH_MX21) += clock-imx21.o mm-imx21.o
+obj-$(CONFIG_SOC_IMX1) += clock-imx1.o mm-imx1.o
+obj-$(CONFIG_SOC_IMX21) += clock-imx21.o mm-imx21.o
 
-obj-$(CONFIG_ARCH_MX25) += clock-imx25.o mm-imx25.o ehci-imx25.o
+obj-$(CONFIG_SOC_IMX25) += clock-imx25.o mm-imx25.o ehci-imx25.o
 
-obj-$(CONFIG_MACH_MX27) += cpu-imx27.o pm-imx27.o
-obj-$(CONFIG_MACH_MX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
+obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
+obj-$(CONFIG_SOC_IMX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
 
 obj-$(CONFIG_SOC_IMX31) += mm-imx31.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o
 obj-$(CONFIG_SOC_IMX35) += mm-imx35.o cpu-imx35.o clock-imx35.o ehci-imx35.o
-- 
1.7.5.4
