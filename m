From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 24 Apr 2012 17:48:17 +0200
Subject: [PATCH v2 1/2] arm: imx: make various struct sys_timer static
In-Reply-To: <1335282498-15896-1-git-send-email-mkl@pengutronix.de>
References: <1335282498-15896-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1335282498-15896-2-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Changes since v1:
* add missing static other mach-imx board files, too

 arch/arm/mach-imx/mach-cpuimx35.c    |    2 +-
 arch/arm/mach-imx/mach-mx1ads.c      |    2 +-
 arch/arm/mach-imx/mach-mx31lite.c    |    2 +-
 arch/arm/mach-imx/mach-mx31moboard.c |    2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c    |    2 +-
 arch/arm/mach-imx/mach-pcm037.c      |    2 +-
 arch/arm/mach-imx/mach-pcm043.c      |    2 +-
 arch/arm/mach-imx/mach-vpr200.c      |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index 8ecc872..c515f8e 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -194,7 +194,7 @@ static void __init eukrea_cpuimx35_timer_init(void)
 	mx35_clocks_init();
 }
 
-struct sys_timer eukrea_cpuimx35_timer = {
+static struct sys_timer eukrea_cpuimx35_timer = {
 	.init	= eukrea_cpuimx35_timer_init,
 };
 
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 9704608..7274e79 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -134,7 +134,7 @@ static void __init mx1ads_timer_init(void)
 	mx1_clocks_init(32000);
 }
 
-struct sys_timer mx1ads_timer = {
+static struct sys_timer mx1ads_timer = {
 	.init	= mx1ads_timer_init,
 };
 
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index 0abef5f..686c605 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -283,7 +283,7 @@ static void __init mx31lite_timer_init(void)
 	mx31_clocks_init(26000000);
 }
 
-struct sys_timer mx31lite_timer = {
+static struct sys_timer mx31lite_timer = {
 	.init	= mx31lite_timer_init,
 };
 
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index f17a15f..1dfe3c7 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -580,7 +580,7 @@ static void __init mx31moboard_timer_init(void)
 	mx31_clocks_init(26000000);
 }
 
-struct sys_timer mx31moboard_timer = {
+static struct sys_timer mx31moboard_timer = {
 	.init	= mx31moboard_timer_init,
 };
 
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 6ae51c6..c433187 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -419,7 +419,7 @@ static void __init mx35pdk_timer_init(void)
 	mx35_clocks_init();
 }
 
-struct sys_timer mx35pdk_timer = {
+static struct sys_timer mx35pdk_timer = {
 	.init	= mx35pdk_timer_init,
 };
 
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 5fddf94..10c9795 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -683,7 +683,7 @@ static void __init pcm037_timer_init(void)
 	mx31_clocks_init(26000000);
 }
 
-struct sys_timer pcm037_timer = {
+static struct sys_timer pcm037_timer = {
 	.init	= pcm037_timer_init,
 };
 
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 237474f..73585f5 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -399,7 +399,7 @@ static void __init pcm043_timer_init(void)
 	mx35_clocks_init();
 }
 
-struct sys_timer pcm043_timer = {
+static struct sys_timer pcm043_timer = {
 	.init	= pcm043_timer_init,
 };
 
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 033257e..add8c69 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -310,7 +310,7 @@ static void __init vpr200_timer_init(void)
 	mx35_clocks_init();
 }
 
-struct sys_timer vpr200_timer = {
+static struct sys_timer vpr200_timer = {
 	.init	= vpr200_timer_init,
 };
 
-- 
1.7.4.1
