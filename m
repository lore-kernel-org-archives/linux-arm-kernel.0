From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Jul 2012 14:02:44 -0600
Subject: [PATCH 2/2] ARM: dt: tegra trimslice: add vbus-gpio property
In-Reply-To: <1343246564-21527-1-git-send-email-swarren@wwwdotorg.org>
References: <1343246564-21527-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1343246564-21527-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

On TrimSlice, Tegra's USB1 port may be routed to either an external micro
USB port, or an internal USB->SATA bridge for SSD or HDD. This muxing is
controlled by a GPIO. Whilst not strictly a VBUS GPIO, the TrimSlice
board files caused this GPIO to be set appropriately to enable the SATA
bridge by passing it as the VBUS GPIO to the USB driver. Echo this same
configuration in device tree to enable the SATA bridge.

An alternative might be to implement a full USB bus mux driver. However,
that seems over-complex right now.

Cc: <stable@vger.kernel.org> # v3.5 (file is named tegra-trimslice.dts there)
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-trimslice.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 84a9523..27fb8a6 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -276,6 +276,7 @@
 
 	usb at c5000000 {
 		status = "okay";
+		nvidia,vbus-gpio = <&gpio 170 0>; /* gpio PV2 */
 	};
 
 	usb at c5004000 {
-- 
1.7.0.4
