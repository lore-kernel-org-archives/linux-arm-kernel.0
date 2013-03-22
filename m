From: ian@slimlogic.co.uk (Ian Lartey)
Date: Fri, 22 Mar 2013 14:55:21 +0000
Subject: [PATCH v10 11/12] clk: Kconfig for Palmas clock driver
In-Reply-To: <1363964122-19201-1-git-send-email-ian@slimlogic.co.uk>
References: <1363964122-19201-1-git-send-email-ian@slimlogic.co.uk>
Message-ID: <1363964122-19201-12-git-send-email-ian@slimlogic.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Ian Lartey <ian@slimlogic.co.uk>
---
 drivers/clk/Kconfig  |    8 ++++++++
 drivers/clk/Makefile |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index a47e6ee..a8e0655 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -63,6 +63,14 @@ config CLK_TWL6040
 	  McPDM. McPDM module is using the external bit clock on the McPDM bus
 	  as functional clock.
 
+config CLK_PALMAS
+	tristate "Palmas PMIC Clock Support"
+	depends on MFD_PALMAS
+	---help---
+	  Enable clock support for the two clocks on Palmas PMIC chips:
+	  - A 32KHz audio-gated clock (primarily for audio devices)
+	  - A digitally-gated 32KHz clock
+
 endmenu
 
 source "drivers/clk/mvebu/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 0147022..34f8d97 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_X86)		+= x86/
 obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
 obj-$(CONFIG_COMMON_CLK_MAX77686) += clk-max77686.o
 obj-$(CONFIG_CLK_TWL6040)	+= clk-twl6040.o
+obj-$(CONFIG_CLK_PALMAS)	+= clk-palmas.o
-- 
1.7.0.4
