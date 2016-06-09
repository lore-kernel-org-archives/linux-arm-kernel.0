From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Thu,  9 Jun 2016 18:25:02 +0200
Subject: [PATCH V2 2/5] dts/imx6q-b850v3: Configure IPU assignment order
In-Reply-To: <cover.1465486875.git.peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <cover.1465486875.git.peter.senna@collabora.com>
Message-ID: <b42202e66ab3a82ad134924c12c50ba64b2d92d1.1465486875.git.peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the IPU has combined limitations across multiple crtcs, and as that
can't be communicated to userspace at the moment, reorder the crtcs to
allow support to two Full-HD monitors by avoiding assigning two
monitors to a single IPU.

Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
Changes from V1:
 - New commit message

 arch/arm/boot/dts/imx6q-b850v3.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index 167f744..88a70de 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -51,6 +51,11 @@
 	chosen {
 		stdout-path = &uart3;
 	};
+
+	display-subsystem {
+		compatible = "fsl,imx-display-subsystem";
+		ports = <&ipu1_di0>, <&ipu2_di0>, <&ipu1_di1>, <&ipu2_di1>;
+	};
 };
 
 &clks {
-- 
2.5.5
