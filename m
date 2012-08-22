From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 22 Aug 2012 15:18:47 +0800
Subject: [PATCH 6/7] ARM: dts: imx6q: add simple-bus compatible string for
 anatop
In-Reply-To: <1345619928-15446-1-git-send-email-b29396@freescale.com>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
Message-ID: <1345619928-15446-7-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Originally the anatop regulator devices are populated by mfd anatop driver.
Since mfd anatop driver will be deleted later, we change to populate the
regulator devices by devicetree automatically.
This will cause some warning messages as follows during boot due to device
recreation: "vdd1p1: Failed to create debugfs directory"
But it does not break any function.
Later, we will remove mfd anatop driver which can get rid of this
error message.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 7076be0..426f735 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -379,7 +379,7 @@
 			};
 
 			anatop: anatop at 020c8000 {
-				compatible = "fsl,imx6q-anatop", "fsl,imx-syscon";
+				compatible = "fsl,imx6q-anatop", "fsl,imx-syscon", "simple-bus";
 				reg = <0x020c8000 0x1000>;
 				interrupts = <0 49 0x04 0 54 0x04 0 127 0x04>;
 
-- 
1.7.0.4
