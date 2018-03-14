From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Mar 2018 14:39:36 -0300
Subject: [PATCH 2/2] ARM: dts: imx53-tx53: Remove unneeded 'codec-handle'
 property
In-Reply-To: <1521049176-22870-1-git-send-email-festevam@gmail.com>
References: <1521049176-22870-1-git-send-email-festevam@gmail.com>
Message-ID: <1521049176-22870-2-git-send-email-festevam@gmail.com>
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
 arch/arm/boot/dts/imx53-tx53.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 69a2af7..77f2ce9 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -550,7 +550,6 @@
 };
 
 &ssi1 {
-	codec-handle = <&sgtl5000>;
 	status = "okay";
 };
 
-- 
2.7.4
