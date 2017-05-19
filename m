From: s-anna@ti.com (Suman Anna)
Date: Fri, 19 May 2017 15:47:42 -0500
Subject: [PATCH 2/2] ARM: dts: am571x-idk: Enable the system mailboxes 5 and 6
In-Reply-To: <20170519204742.1563-1-s-anna@ti.com>
References: <20170519204742.1563-1-s-anna@ti.com>
Message-ID: <20170519204742.1563-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the System Mailboxes 5 and 6 and the corresponding
child sub-mailbox (IPC 3.x) nodes for the AM571x IDK board.
This is needed to enable communication with the respective
remote processors IPU1, IPU2, and DSP1 from the MPU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index ad68d1eb3bc3..7b207835b2d1 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -79,3 +79,20 @@
 	id-gpio = <&gpio5 7 GPIO_ACTIVE_HIGH>;
 	vbus-gpio = <&gpio7 22 GPIO_ACTIVE_HIGH>;
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
+};
-- 
2.12.0
