From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Feb 2014 18:21:01 +0100
Subject: [PATCH v2 6/7] ARM: mvebu: enable S/PDIF audio in Armada 370 DB
 Device Tree
In-Reply-To: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392225662-20431-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to the analog audio input and output, the Armada 370 DB
also has S/PDIF input and output optical connectors. This commit
improves the Device Tree description of the Armada 370 DB platform to
enable the S/PDIF support.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 7df1866..82f238a 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -163,7 +163,15 @@
 	sound {
 	      compatible = "marvell,a370db-audio";
 	      marvell,audio-controller = <&audio_controller>;
-	      marvell,audio-codec = <&audio_codec>;
+	      marvell,audio-codec = <&audio_codec &spdif_out &spdif_in>;
 	      status = "okay";
 	};
+
+	spdif_out: spdif-out {
+	      compatible = "linux,spdif-dit";
+	};
+
+	spdif_in: spdif-in {
+	      compatible = "linux,spdif-dir";
+	};
 };
-- 
1.8.3.2
