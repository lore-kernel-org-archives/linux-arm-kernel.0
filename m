From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 27 Aug 2012 15:24:44 +0800
Subject: [PATCH v2 6/7] ARM: dts: imx6q: add simple-bus compatible string for
 anatop
In-Reply-To: <1346052285-4344-1-git-send-email-b29396@freescale.com>
References: <1346052285-4344-1-git-send-email-b29396@freescale.com>
Message-ID: <1346052285-4344-7-git-send-email-b29396@freescale.com>
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
index da2bb71..0ebf853 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -379,7 +379,7 @@
 			};
 
 			anatop: anatop at 020c8000 {
-				compatible = "fsl,imx6q-anatop", "syscon";
+				compatible = "fsl,imx6q-anatop", "syscon", "simple-bus";
 				reg = <0x020c8000 0x1000>;
 				interrupts = <0 49 0x04 0 54 0x04 0 127 0x04>;
 
-- 
1.7.0.4
