From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Mar 2018 14:39:35 -0300
Subject: [PATCH 1/2] ARM: dts: imx25-pdk: Remove unneeded 'codec-handle'
 property
Message-ID: <1521049176-22870-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The 'codec-handle' property is an optional one and there is really
no need to be used here.

As per the comment in the fsl_ssi driver:

"Backward compatible for older bindings by manually triggering the
machine driver's probe()."

,so just remove such uneeded property.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx25-pdk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 7f9bd05..7696e0c0 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -291,7 +291,6 @@
 };
 
 &ssi1 {
-	codec-handle = <&codec>;
 	status = "okay";
 };
 
-- 
2.7.4
