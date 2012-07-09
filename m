From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 14:14:56 +0800
Subject: [PATCH 7/7] ARM: mxs: add dtb-y target into Makefile.boot
In-Reply-To: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1341814496-17487-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dtb-y target into Makefile.boot, so that "make ARCH=arm dtbs" can
build out all the dtbs listed there.  It's very useful for build-testing
all the <board>.dts when imx28.dtsi changes.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/Makefile.boot |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Makefile.boot b/arch/arm/mach-mxs/Makefile.boot
index 07b11fe..58733cc 100644
--- a/arch/arm/mach-mxs/Makefile.boot
+++ b/arch/arm/mach-mxs/Makefile.boot
@@ -1 +1,10 @@
 zreladdr-y += 0x40008000
+
+dtb-y += apx4devkit.dtb \
+	 cfa10036.dtb \
+	 imx23-evk.dtb \
+	 imx23-olinuxino.dtb \
+	 imx28-evk.dtb \
+	 m28evk.dtb \
+	 stmp378x_devb.dtb \
+	 tx28.dtb \
-- 
1.7.5.4
