From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 27 Feb 2014 16:42:45 +0800
Subject: [PATCH 3/3] ARM: imx6: build suspend-imx6.o with CONFIG_SOC_IMX6
In-Reply-To: <1393490565-26387-1-git-send-email-shawn.guo@linaro.org>
References: <1393490565-26387-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1393490565-26387-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even when CONFIG_SUSPEND is enabled, it makes no sense to build
suspend-imx6.o if none of i.MX6 support is built in.  Let's build
suspend-imx6.o only when both CONFIG_SUSPEND and CONFIG_SOC_IMX6 are
enabled.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 19a6d0e..f4ed830 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -102,8 +102,10 @@ obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
 
+ifeq ($(CONFIG_SUSPEND),y)
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
-obj-$(CONFIG_SUSPEND) += suspend-imx6.o
+obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
+endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
 
 # i.MX5 based machines
-- 
1.7.9.5
