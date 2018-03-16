From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:50:40 +0100
Subject: [PATCH 2/3] arm64: defconfig: Enable PWM and USB for R-Car
In-Reply-To: <cover.1521201256.git.horms+renesas@verge.net.au>
References: <cover.1521201256.git.horms+renesas@verge.net.au>
Message-ID: <5cb300ce806bfe3273bb94d373d43ca35c33ffdf.1521201256.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Enables PWM controller, USB-DMAC that is used by HS-USB, USB 3.0
peripheral controller and USB 3.0 PHY for R-Car SoCs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a850bc5e1af3..ceafd26f0fab 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -445,6 +445,7 @@ CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
+CONFIG_USB_RENESAS_USB3=m
 CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
@@ -501,6 +502,7 @@ CONFIG_QCOM_BAM_DMA=y
 CONFIG_QCOM_HIDMA_MGMT=y
 CONFIG_QCOM_HIDMA=y
 CONFIG_RCAR_DMAC=y
+CONFIG_RENESAS_USB_DMAC=m
 CONFIG_VFIO=y
 CONFIG_VFIO_PCI=y
 CONFIG_VIRTIO_PCI=y
@@ -548,10 +550,12 @@ CONFIG_PWM=y
 CONFIG_PWM_BCM2835=m
 CONFIG_PWM_CROS_EC=m
 CONFIG_PWM_MESON=m
+CONFIG_PWM_RCAR=m
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_TEGRA=m
 CONFIG_PHY_RCAR_GEN3_USB2=y
+CONFIG_PHY_RCAR_GEN3_USB3=m
 CONFIG_PHY_HI6220_USB=y
 CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_SUN4I_USB=y
-- 
2.11.0
