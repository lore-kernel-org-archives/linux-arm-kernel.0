From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 24 Mar 2013 22:06:04 +0800
Subject: [PATCH 1/2] ARM: imx_v6_v7_defconfig: add CONFIG_USB_PHY
Message-ID: <1364133966-22373-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit edc7cb2 (usb: phy: make it a menuconfig) makes USB_MXS_PHY
be a sub-item of menuconfig symbol USB_PHY.  This change gets the
selection of CONFIG_USB_MXS_PHY in imx_v6_v7_defconfig lost.  Hence the
boot stops at the point below.

  ci_hdrc ci_hdrc.0: doesn't support gadget
  ci_hdrc ci_hdrc.0: EHCI Host Controller
  ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1

Add CONFIG_USB_PHY to have the CONFIG_USB_MXS_PHY selection back to
work.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e36b010..088d6c1 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -188,6 +188,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_PHY=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
-- 
1.7.9.5
