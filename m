From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 27 Aug 2018 15:32:39 +0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Make usbnet drivers builtin for boot
Message-ID: <ab02224d560e09e96af2e41fbfa155e40e8bbb75.1535373073.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chips such as imx6sll and imx7ulp have no ethernet support so the common
development usecase of nfs boot is supported via usb ethernet dongles.

Add drivers for additional usbnet device directly into the kernel image
image produced by the imx defconfig.

This list is based on the usbnet devices supported by uboot.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
This is not a very pretty solution but very convenient.
---
 arch/arm/configs/imx_v6_v7_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e2c127608bcc..7474bb5b3a6f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -147,13 +147,16 @@ CONFIG_SMSC911X=y
 CONFIG_AT803X_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
-CONFIG_USB_RTL8152=m
+CONFIG_USB_RTL8152=y
+CONFIG_USB_LAN78XX=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_CDC_EEM=m
+CONFIG_USB_NET_SMSC95XX=y
+CONFIG_USB_NET_MCS7830=y
 CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
 CONFIG_MWIFIEX_PCIE=m
 CONFIG_WL12XX=m
-- 
2.17.1
