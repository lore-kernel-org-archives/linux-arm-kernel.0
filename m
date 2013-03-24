From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 24 Mar 2013 22:06:05 +0800
Subject: [PATCH 2/2] ARM: mxs_defconfig: add CONFIG_USB_PHY
In-Reply-To: <1364133966-22373-1-git-send-email-shawn.guo@linaro.org>
References: <1364133966-22373-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364133966-22373-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit edc7cb2 (usb: phy: make it a menuconfig) makes USB_MXS_PHY
be a sub-item of menuconfig symbol USB_PHY.  This change gets the
selection of CONFIG_USB_MXS_PHY in mxs_defconfig lost.  Hence the
boot stops at the point below.

  [    1.600867] ci_hdrc ci_hdrc.0: doesn't support gadget
  [    1.606282] ci_hdrc ci_hdrc.0: EHCI Host Controller
  [    1.613522] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1

Add CONFIG_USB_PHY to have the CONFIG_USB_MXS_PHY selection back to
work.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/mxs_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index e9b1f6d..7ba48d2 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -122,6 +122,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_PHY=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
-- 
1.7.9.5
