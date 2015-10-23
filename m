From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sat, 24 Oct 2015 01:01:58 +0530
Subject: [PATCH v4 09/12] dts/ls2080a: Update Simulator DTS to add support of
 various peripherals
In-Reply-To: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1445628721-10483-10-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the LS2080a simulator DTS to add support of various
peripherals which are supported on the simulator platform and explicitly
disables those which are yet not supported on the platform.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
index 33d6d0c..3676c02 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
@@ -57,9 +57,19 @@
 	model = "Freescale Layerscape 2080a software Simulator model";
 	compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
 
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+	};
+
 	ethernet at 2210000 {
 		compatible = "smsc,lan91c111";
 		reg = <0x0 0x2210000 0x0 0x100>;
 		interrupts = <0 58 0x1>;
 	};
 };
+
+&ifc {
+	status = "okay";
+};
+
-- 
1.7.9.5
