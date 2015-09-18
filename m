From: s-anna@ti.com (Suman Anna)
Date: Fri, 18 Sep 2015 13:16:34 -0500
Subject: [PATCH 5/5] ARM: dts: beagle-x15: Enable the system mailboxes 5 and 6
In-Reply-To: <1442600194-62520-1-git-send-email-s-anna@ti.com>
References: <1442600194-62520-1-git-send-email-s-anna@ti.com>
Message-ID: <1442600194-62520-6-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the System Mailboxes 5 and 6 and the corresponding child
sub-mailbox (IPC 3.x) nodes for the Beagle X15 EVM boards. This
is needed to enable communication with the respective remote
processors IPU1, IPU2, DSP1 and DSP2 from the MPU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 3a05b94f59ed..4a13419ab025 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -696,3 +696,23 @@
 &pcie1 {
 	gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
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
