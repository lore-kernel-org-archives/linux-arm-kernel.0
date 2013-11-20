From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 20 Nov 2013 02:06:15 +0100
Subject: [PATCH v2 11/11] ARM: dts: omap3-igep0020: name twl4030 VPLL2
 regulator as vdds_dsi
In-Reply-To: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1384909575-19108-12-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Device Tree boot the VDDS_DSI regulator is not linked to
the DPI device so omapfb driver probing fails with:

[    3.186035] OMAPFB: omapfb_probe
[    3.190704] omapdss DPI error: can't get VDDS_DSI regulator
[    3.196594] omapfb omapfb: failed to connect default display
[    3.202667] omapfb omapfb: failed to init overlay connections
[    3.208892] OMAPFB: free_resources
[    3.212493] OMAPFB: free all fbmem
[    3.216735] omapfb omapfb: failed to setup omapfb

As a workaround name the VPLL2 regulator from twl4030 as vdds_dsi
so getting the VDDS_DSI regulator will succeed on dpi_init_regulator().

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep0020.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index b9a9e17..1c7e74d 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -215,3 +215,8 @@
 &usbhsehci {
 	phys = <&hsusb1_phy>;
 };
+
+&vpll2 {
+        /* Needed for DSS */
+        regulator-name = "vdds_dsi";
+};
-- 
1.8.4.2
