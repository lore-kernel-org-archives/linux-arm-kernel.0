From: s-anna@ti.com (Suman Anna)
Date: Fri, 19 May 2017 15:47:41 -0500
Subject: [PATCH 1/2] ARM: dts: am572x-idk: Enable the system mailboxes 5 and 6
In-Reply-To: <20170519204742.1563-1-s-anna@ti.com>
References: <20170519204742.1563-1-s-anna@ti.com>
Message-ID: <20170519204742.1563-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the System Mailboxes 5 and 6 and the corresponding
child sub-mailbox (IPC 3.x) nodes for the AM572x IDK board.
This is needed to enable communication with the respective
remote processors IPU1, IPU2, DSP1 and DSP2 from the MPU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am572x-idk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 8350b4b34b08..9da6d83ca185 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -91,3 +91,23 @@
 &pcie1 {
 	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
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
2.12.0
