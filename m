From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 24 Jun 2014 11:19:58 +0100
Subject: [PATCH v3 7/8] ARM: dts: cubox-i: add eSATA DT configuration
In-Reply-To: <20140624101901.GL32514@n2100.arm.linux.org.uk>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Message-ID: <E1WzNpW-0005e5-41@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the transmit level, boost and attenuation parameters necessary for
the eSATA interface on Cubox-i to work.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6q-cubox-i.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/imx6q-cubox-i.dts
index bc5f31e3e892..941365d7ee65 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i.dts
@@ -13,4 +13,7 @@
 
 &sata {
 	status = "okay";
+	fsl,transmit-level-mV = <1104>;
+	fsl,transmit-boost-mdB = <0>;
+	fsl,transmit-atten-16ths = <9>;
 };
-- 
1.8.3.1
