From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Dec 2012 15:49:13 +0100
Subject: [PATCH v2 14/20] arm: kirkwood: add pinmux option for the SDIO
 interface on 88F6282
In-Reply-To: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1356101359-6054-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a pinmux option, pmx_sdio, to enable the muxing of
the SDIO interface on the 88F6282 SoC from Marvell.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Changes since v1:
 * This patch is new in v2.
---
 arch/arm/boot/dts/kirkwood-6282.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 9ae2004..0386ae4 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -30,6 +30,11 @@
 				marvell,pins = "mpp13", "mpp14";
 				marvell,function = "uart1";
 			};
+			pmx_sdio: pmx-sdio {
+				marvell,pins = "mpp12", "mpp13", "mpp14",
+					       "mpp15", "mpp16", "mpp17";
+				marvell,function = "sdio";
+			};
 		};
 
 		i2c at 11100 {
-- 
1.7.9.5
