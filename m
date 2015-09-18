From: s-anna@ti.com (Suman Anna)
Date: Fri, 18 Sep 2015 13:16:32 -0500
Subject: [PATCH 3/5] ARM: dts: dra7-evm: Enable the system mailboxes 5 and 6
In-Reply-To: <1442600194-62520-1-git-send-email-s-anna@ti.com>
References: <1442600194-62520-1-git-send-email-s-anna@ti.com>
Message-ID: <1442600194-62520-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the System Mailboxes 5 and 6 and the corresponding
child sub-mailbox (IPC 3.x) nodes for the DRA7 EVM board.
This is needed to enable communication with the respective
remote processors IPU1, IPU2, DSP1 and DSP2 from the MPU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index a6c82e5b64fe..718315ac3063 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -707,3 +707,23 @@
 	pinctrl-1 = <&dcan1_pins_sleep>;
 	pinctrl-2 = <&dcan1_pins_default>;
 };
+
+&mailbox5 {
+	status = "okay";
+	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
+		status = "okay";
+	};
+	mbox_dsp1_ipc3x: mbox_dsp1_ipc3x {
+		status = "okay";
+	};
+};
+
+&mailbox6 {
+	status = "okay";
+	mbox_ipu2_ipc3x: mbox_ipu2_ipc3x {
+		status = "okay";
+	};
+	mbox_dsp2_ipc3x: mbox_dsp2_ipc3x {
+		status = "okay";
+	};
+};
-- 
2.5.0
