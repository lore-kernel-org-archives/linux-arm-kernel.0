From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 30 Jul 2013 10:54:17 +0800
Subject: [PATCH 2/2] imx: pinctrl: change XXX_USB_OTG_ID configuration
In-Reply-To: <1375152857-32177-1-git-send-email-peter.chen@freescale.com>
References: <1375152857-32177-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1375152857-32177-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The XXX_USB_OTG_ID select input chosen is not at common select
input register region, we add exception for this pin configration.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6q-pinfunc.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-pinfunc.h b/arch/arm/boot/dts/imx6q-pinfunc.h
index faea6e1..a40a5a6 100644
--- a/arch/arm/boot/dts/imx6q-pinfunc.h
+++ b/arch/arm/boot/dts/imx6q-pinfunc.h
@@ -532,7 +532,7 @@
 #define MX6Q_PAD_ENET_REF_CLK__ESAI_RX_FS         0x1d4 0x4e8 0x85c 0x2 0x0
 #define MX6Q_PAD_ENET_REF_CLK__GPIO1_IO23         0x1d4 0x4e8 0x000 0x5 0x0
 #define MX6Q_PAD_ENET_REF_CLK__SPDIF_SR_CLK       0x1d4 0x4e8 0x000 0x6 0x0
-#define MX6Q_PAD_ENET_RX_ER__USB_OTG_ID           0x1d8 0x4ec 0x000 0x0 0x0
+#define MX6Q_PAD_ENET_RX_ER__USB_OTG_ID           0x1d8 0x4ec 0xfff 0x0 0x0
 #define MX6Q_PAD_ENET_RX_ER__ENET_RX_ER           0x1d8 0x4ec 0x000 0x1 0x0
 #define MX6Q_PAD_ENET_RX_ER__ESAI_RX_HF_CLK       0x1d8 0x4ec 0x864 0x2 0x0
 #define MX6Q_PAD_ENET_RX_ER__SPDIF_IN             0x1d8 0x4ec 0x914 0x3 0x1
@@ -650,7 +650,7 @@
 #define MX6Q_PAD_GPIO_1__ESAI_RX_CLK              0x224 0x5f4 0x86c 0x0 0x1
 #define MX6Q_PAD_GPIO_1__WDOG2_B                  0x224 0x5f4 0x000 0x1 0x0
 #define MX6Q_PAD_GPIO_1__KEY_ROW5                 0x224 0x5f4 0x8f4 0x2 0x0
-#define MX6Q_PAD_GPIO_1__USB_OTG_ID               0x224 0x5f4 0x000 0x3 0x0
+#define MX6Q_PAD_GPIO_1__USB_OTG_ID               0x224 0x5f4 0xfff 0x3 0x1
 #define MX6Q_PAD_GPIO_1__PWM2_OUT                 0x224 0x5f4 0x000 0x4 0x0
 #define MX6Q_PAD_GPIO_1__GPIO1_IO01               0x224 0x5f4 0x000 0x5 0x0
 #define MX6Q_PAD_GPIO_1__SD1_CD_B                 0x224 0x5f4 0x000 0x6 0x0
-- 
1.7.0.4
