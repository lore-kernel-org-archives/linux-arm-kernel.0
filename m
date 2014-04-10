From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 10 Apr 2014 16:33:50 +0900
Subject: [PATCH] ARM: shmobile: Enable USB [EO]HCI HCD support in
 shmobile_defconfig
Message-ID: <1397115230-18437-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB [EO]HCI HCD drivers provide USB host support for Renesas
R-Car Gen2 platforms. To increase hardware support enable the driver in the
shmobile_defconfig multiplatform configuration.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

* Applies on top of renesas-devel-v3.14-20140409v2

* Tested with the following patches applied:
  sh_eth: add device tree support
  ARM: shmobile: Koelsch DT reference USB pinmux setup
  ARM: shmobile: Koelsch DT reference USB platform devices
  ARM: shmobile: Lager DT reference USB pinmux setup
  ARM: shmobile: Lager DT reference USB platform devices
  gpio: rcar: Per-controller gpios property prototype
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 8fb30b0..6d6437c 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -110,6 +110,8 @@ CONFIG_SND_SOC=y
 CONFIG_SND_SOC_RCAR=y
 CONFIG_USB=y
 CONFIG_USB_RCAR_GEN2_PHY=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_RENESAS_USBHS=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=y
-- 
1.8.5.2
