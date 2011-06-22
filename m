From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 22 Jun 2011 11:31:00 -0300
Subject: [PATCH] ARM: mxc: iomux-v1: Fix build warning
Message-ID: <1308753060-14489-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warning:

CC      arch/arm/plat-mxc/iomux-v1.o
arch/arm/plat-mxc/iomux-v1.c: In function 'mxc_gpio_setup_multiple_pins':
arch/arm/plat-mxc/iomux-v1.c:160: warning: 'ret' may be used uninitialized in this function
arch/arm/plat-mxc/iomux-v1.c:160: note: 'ret' was declared here

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/iomux-v1.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/iomux-v1.c b/arch/arm/plat-mxc/iomux-v1.c
index d76f3ac..1f73963 100644
--- a/arch/arm/plat-mxc/iomux-v1.c
+++ b/arch/arm/plat-mxc/iomux-v1.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL(mxc_gpio_mode);
 static int imx_iomuxv1_setup_multiple(const int *list, unsigned count)
 {
 	size_t i;
-	int ret;
+	int ret = 0;
 
 	for (i = 0; i < count; ++i) {
 		ret = mxc_gpio_mode(list[i]);
-- 
1.6.0.4
