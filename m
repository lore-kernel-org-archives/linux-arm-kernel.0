From: s-anna@ti.com (Suman Anna)
Date: Fri, 18 Sep 2015 13:16:33 -0500
Subject: [PATCH 4/5] ARM: dts: dra72-evm: Enable the system mailboxes 5 and 6
In-Reply-To: <1442600194-62520-1-git-send-email-s-anna@ti.com>
References: <1442600194-62520-1-git-send-email-s-anna@ti.com>
Message-ID: <1442600194-62520-5-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the System Mailboxes 5 and 6 and the corresponding
child sub-mailbox (IPC 3.x) nodes for the DRA72 EVM board.
This is needed to enable communication with the respective
remote processors IPU1, IPU2, and DSP1 from the MPU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 6f6bd98c98df..ccb535b5ef9b 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -695,3 +695,20 @@
 		};
 	};
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
2.5.0
