From: jason77.wang@gmail.com (Jason Wang)
Date: Sat, 12 Jun 2010 22:22:37 +0800
Subject: [PATCH 2/4] mx51/iomux: Fix mux mode and input path for two pads
In-Reply-To: <1276352559-8105-2-git-send-email-jason77.wang@gmail.com>
References: <1276352559-8105-1-git-send-email-jason77.wang@gmail.com>
	<1276352559-8105-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <1276352559-8105-3-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For pad EIM_D27 to work in UART3_RTS mode, the input path should be
3 instead of 0; for pad USBH1_STP to work in GPIO_1_27 mode, the mux
value should be 2 instead of 8.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index e8648bc..7433369 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -78,7 +78,7 @@ typedef enum iomux_config {
 #define MX51_PAD_EIM_D24__UART3_CTS             IOMUX_PAD(0x410, 0x07c, 3, 0x0,   0, MX51_UART3_PAD_CTRL)
 #define MX51_PAD_EIM_D25__UART3_RXD             IOMUX_PAD(0x414, 0x080, 3, 0x9f4, 0, MX51_UART3_PAD_CTRL)
 #define MX51_PAD_EIM_D26__UART3_TXD             IOMUX_PAD(0x418, 0x084, 3, 0x0,   0, MX51_UART3_PAD_CTRL)
-#define MX51_PAD_EIM_D27__UART3_RTS             IOMUX_PAD(0x41c, 0x088, 3, 0x9f0, 0, MX51_UART3_PAD_CTRL)
+#define MX51_PAD_EIM_D27__UART3_RTS             IOMUX_PAD(0x41c, 0x088, 3, 0x9f0, 3, MX51_UART3_PAD_CTRL)
 #define MX51_PAD_EIM_D28__EIM_D28               IOMUX_PAD(0x420, 0x08c, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_EIM_D29__EIM_D29               IOMUX_PAD(0x424, 0x090, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_EIM_D30__EIM_D30               IOMUX_PAD(0x428, 0x094, 0, 0x0,   0, NO_PAD_CTRL)
@@ -207,7 +207,7 @@ typedef enum iomux_config {
 #define MX51_PAD_USBH1_CLK__USBH1_CLK           IOMUX_PAD(0x678, 0x278, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
 #define MX51_PAD_USBH1_DIR__USBH1_DIR           IOMUX_PAD(0x67C, 0x27C, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
 #define MX51_PAD_USBH1_STP__USBH1_STP           IOMUX_PAD(0x680, 0x280, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
-#define MX51_PAD_USBH1_STP__GPIO_1_27           IOMUX_PAD(0x680, 0x280, IOMUX_CONFIG_GPIO, 0x0,   0, MX51_USBH1_PAD_CTRL)
+#define MX51_PAD_USBH1_STP__GPIO_1_27           IOMUX_PAD(0x680, 0x280, 2, 0x0,   0, MX51_USBH1_PAD_CTRL)
 #define MX51_PAD_USBH1_NXT__USBH1_NXT           IOMUX_PAD(0x684, 0x284, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
 #define MX51_PAD_USBH1_DATA0__USBH1_DATA0       IOMUX_PAD(0x688, 0x288, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
 #define MX51_PAD_USBH1_DATA1__USBH1_DATA1       IOMUX_PAD(0x68C, 0x28C, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
-- 
1.5.6.5
