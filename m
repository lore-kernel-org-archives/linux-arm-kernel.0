From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Feb 2013 14:03:58 -0300
Subject: [PATCH] ARM: mxs_defconfig: Make USB host functional again
Message-ID: <1361984638-19725-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

commit 09f6ffde2e (USB: EHCI: fix build error by making ChipIdea host a normal 
EHCI driver) introduced CONFIG_USB_EHCI_HCD as a dependency for USB_CHIPIDEA_HOST.

Select CONFIG_USB_EHCI_HCD, so that USB host can be functional again.

Cc: <stable@vger.kernel.org> # 3.8
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
On 3.7.9 USB host works fine on mx28, but it is broken on 3.8.

So this is a regression and that's why stable is put in Cc.
 arch/arm/configs/mxs_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 7bf5351..a55b206 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -118,6 +118,7 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FONTS=y
 CONFIG_LOGO=y
 CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_STORAGE=y
-- 
1.7.9.5
