From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Tue, 19 Sep 2017 17:26:55 +0800
Subject: [PATCH 2/5] arm64: dts: ls1012a: Add MSI controller DT node
In-Reply-To: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
References: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20170919092658.22482-3-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add MSI controller node for ls1012a platform.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index df83915d6ea6..a7698ac7264b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -471,5 +471,12 @@
 			dr_mode = "host";
 			phy_type = "ulpi";
 		};
+
+		msi: msi-controller1 at 1572000 {
+			compatible = "fsl,ls1012a-msi";
+			reg = <0x0 0x1572000 0x0 0x8>;
+			msi-controller;
+			interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.14.1
