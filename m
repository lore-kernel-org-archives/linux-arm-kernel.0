From: abhishek.shah@broadcom.com (Abhishek Shah)
Date: Sat, 29 Jul 2017 10:12:29 +0530
Subject: [PATCH 7/7] arm64: dts: Add SBA-RAID DT nodes for Stingray SoC
In-Reply-To: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
References: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
Message-ID: <1501303349-30007-8-git-send-email-abhishek.shah@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anup Patel <anup.patel@broadcom.com>

This patch adds Broadcom SBA-RAID DT nodes for Stingray SoC.

The Stingray SoC has total 32 SBA-RAID FlexRM rings and it has
8 CPUs so we create 8 SBA-RAID instances (one for each CPU).
This way Linux DMAENGINE will have one SBA-RAID DMA device for
each CPU.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray-fs4.dtsi   | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
index 1f927c4..8bf1dc6 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
@@ -51,4 +51,68 @@
 			msi-parent = <&gic_its 0x4300>;
 			#mbox-cells = <3>;
 		};
+
+		raid0: raid at 0 {
+			compatible = "brcm,iproc-sba-v2";
+			mboxes = <&raid_mbox 0 0x1 0xff00>,
+				 <&raid_mbox 1 0x1 0xff00>,
+				 <&raid_mbox 2 0x1 0xff00>,
+				 <&raid_mbox 3 0x1 0xff00>;
+		};
+
+		raid1: raid at 1 {
+			compatible = "brcm,iproc-sba-v2";
+			mboxes = <&raid_mbox 4 0x1 0xff00>,
+				 <&raid_mbox 5 0x1 0xff00>,
+				 <&raid_mbox 6 0x1 0xff00>,
+				 <&raid_mbox 7 0x1 0xff00>;
+		};
+
+		raid2: raid at 2 {
+			compatible = "brcm,iproc-sba-v2";
+			mboxes = <&raid_mbox 8 0x1 0xff00>,
+				 <&raid_mbox 9 0x1 0xff00>,
+				 <&raid_mbox 10 0x1 0xff00>,
+				 <&raid_mbox 11 0x1 0xff00>;
+		};
+
+		raid3: raid at 3 {
+			compatible = "brcm,iproc-sba-v2";
+			mboxes = <&raid_mbox 12 0x1 0xff00>,
+				 <&raid_mbox 13 0x1 0xff00>,
+				 <&raid_mbox 14 0x1 0xff00>,
+				 <&raid_mbox 15 0x1 0xff00>;
+		};
+
+		raid4: raid at 4 {
+			compatible = "brcm,iproc-sba-v2";
+			mboxes = <&raid_mbox 16 0x1 0xff00>,
+				 <&raid_mbox 17 0x1 0xff00>,
+				 <&raid_mbox 18 0x1 0xff00>,
+				 <&raid_mbox 19 0x1 0xff00>;
+		};
+
+		raid5: raid at 5 {
+			compatible = "brcm,iproc-sba-v2";
+			mboxes = <&raid_mbox 20 0x1 0xff00>,
+				 <&raid_mbox 21 0x1 0xff00>,
+				 <&raid_mbox 22 0x1 0xff00>,
+				 <&raid_mbox 23 0x1 0xff00>;
+		};
+
+		raid6: raid at 6 {
+			compatible = "brcm,iproc-sba-v2";
+			mboxes = <&raid_mbox 24 0x1 0xff00>,
+				 <&raid_mbox 25 0x1 0xff00>,
+				 <&raid_mbox 26 0x1 0xff00>,
+				 <&raid_mbox 27 0x1 0xff00>;
+		};
+
+		raid7: raid at 7 {
+			compatible = "brcm,iproc-sba-v2";
+			mboxes = <&raid_mbox 28 0x1 0xff00>,
+				 <&raid_mbox 29 0x1 0xff00>,
+				 <&raid_mbox 30 0x1 0xff00>,
+				 <&raid_mbox 31 0x1 0xff00>;
+		};
 	};
-- 
2.7.4
