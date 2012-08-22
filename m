From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 22 Aug 2012 15:18:44 +0800
Subject: [PATCH 3/7] ARM: imx6q: add anatop support into imx-syscon
In-Reply-To: <1345619928-15446-1-git-send-email-b29396@freescale.com>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
Message-ID: <1345619928-15446-4-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

There're a few anatop registers need to be accessed by different modules.
Add anatop registers into imx-syscon support for easy access.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 1306868..7732b70 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -378,8 +378,8 @@
 				interrupts = <0 87 0x04 0 88 0x04>;
 			};
 
-			anatop at 020c8000 {
-				compatible = "fsl,imx6q-anatop";
+			anatop: anatop at 020c8000 {
+				compatible = "fsl,imx6q-anatop", "fsl,imx-syscon";
 				reg = <0x020c8000 0x1000>;
 				interrupts = <0 49 0x04 0 54 0x04 0 127 0x04>;
 
-- 
1.7.0.4
