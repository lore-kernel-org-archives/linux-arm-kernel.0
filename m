From: olof@lixom.net (Olof Johansson)
Date: Wed,  9 Nov 2011 10:34:51 -0800
Subject: [PATCH] arm/tegra: fix variable formatting in makefile
Message-ID: <1320863691-22922-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason it started out using {} instead of (), and it's
proliferated from there. Switch back to ().

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/Makefile |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 91a07e1..5be8e9e 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -18,20 +18,20 @@ obj-$(CONFIG_CPU_FREQ)                  += cpu-tegra.o
 obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 obj-$(CONFIG_USB_SUPPORT)		+= usb_phy.o
 
-obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
-obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
-obj-${CONFIG_MACH_HARMONY}              += board-harmony-pcie.o
-obj-${CONFIG_MACH_HARMONY}              += board-harmony-power.o
+obj-$(CONFIG_MACH_HARMONY)              += board-harmony.o
+obj-$(CONFIG_MACH_HARMONY)              += board-harmony-pinmux.o
+obj-$(CONFIG_MACH_HARMONY)              += board-harmony-pcie.o
+obj-$(CONFIG_MACH_HARMONY)              += board-harmony-power.o
 
-obj-${CONFIG_MACH_PAZ00}		+= board-paz00.o
-obj-${CONFIG_MACH_PAZ00}		+= board-paz00-pinmux.o
+obj-$(CONFIG_MACH_PAZ00)		+= board-paz00.o
+obj-$(CONFIG_MACH_PAZ00)		+= board-paz00-pinmux.o
 
-obj-${CONFIG_MACH_SEABOARD}             += board-seaboard.o
-obj-${CONFIG_MACH_SEABOARD}             += board-seaboard-pinmux.o
+obj-$(CONFIG_MACH_SEABOARD)             += board-seaboard.o
+obj-$(CONFIG_MACH_SEABOARD)             += board-seaboard-pinmux.o
 
-obj-${CONFIG_MACH_TEGRA_DT}             += board-dt.o
-obj-${CONFIG_MACH_TEGRA_DT}             += board-harmony-pinmux.o
-obj-${CONFIG_MACH_TEGRA_DT}             += board-seaboard-pinmux.o
+obj-$(CONFIG_MACH_TEGRA_DT)             += board-dt.o
+obj-$(CONFIG_MACH_TEGRA_DT)             += board-harmony-pinmux.o
+obj-$(CONFIG_MACH_TEGRA_DT)             += board-seaboard-pinmux.o
 
-obj-${CONFIG_MACH_TRIMSLICE}            += board-trimslice.o
-obj-${CONFIG_MACH_TRIMSLICE}            += board-trimslice-pinmux.o
+obj-$(CONFIG_MACH_TRIMSLICE)            += board-trimslice.o
+obj-$(CONFIG_MACH_TRIMSLICE)            += board-trimslice-pinmux.o
-- 
1.7.5.4
