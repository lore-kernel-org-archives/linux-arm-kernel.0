From: nm@ti.com (Nishanth Menon)
Date: Wed, 11 Dec 2013 04:21:45 -0600
Subject: [PATCH 2/2] ARM: dts: omap2430-sdp: add flags for ethernet
 functionality
In-Reply-To: <1386757305-12545-1-git-send-email-nm@ti.com>
References: <1386757305-12545-1-git-send-email-nm@ti.com>
Message-ID: <1386757305-12545-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ethernet transition from board file to dts missed the required pdata
conversion. So fix the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap2430-sdp.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap2430-sdp.dts b/arch/arm/boot/dts/omap2430-sdp.dts
index 2c90d29..ec9263a 100644
--- a/arch/arm/boot/dts/omap2430-sdp.dts
+++ b/arch/arm/boot/dts/omap2430-sdp.dts
@@ -39,6 +39,11 @@
 	ranges = <5 0 0x08000000 0x01000000>;
 	ethernet at gpmc {
 		compatible = "smsc,lan91c94";
+		reg-io-width = <2>;
+		smsc,nowait;
+		smsc,leda = "100_10";
+		smsc,ledb = "TX_RX";
+
 		interrupt-parent = <&gpio5>;
 		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;	/* gpio149 */
 		reg = <5 0x300 0xf>;
-- 
1.7.9.5
