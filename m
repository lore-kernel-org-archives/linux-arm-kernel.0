From: hotran@apm.com (Hoan Tran)
Date: Thu, 21 Jul 2016 13:55:57 -0700
Subject: [PATCH v3 3/3] arm64: dts: apm: Add X-Gene SoC hwmon to device tree
In-Reply-To: <1469134557-26869-1-git-send-email-hotran@apm.com>
References: <1469134557-26869-1-git-send-email-hotran@apm.com>
Message-ID: <1469134557-26869-4-git-send-email-hotran@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT node to enable hwmon driver for APM X-Gene SoC.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 5 +++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index c569f76..a5935f5 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -472,6 +472,11 @@
 			mboxes = <&mailbox 0>;
 		};
 
+		hwmonslimpro {
+			compatible = "apm,xgene-slimpro-hwmon";
+			mboxes = <&mailbox 7>;
+		};
+
 		serial0: serial at 10600000 {
 			device_type = "serial";
 			compatible = "ns16550";
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 5147d76..f8ea5b5 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -716,6 +716,11 @@
 			mboxes = <&mailbox 0>;
 		};
 
+		hwmonslimpro {
+			compatible = "apm,xgene-slimpro-hwmon";
+			mboxes = <&mailbox 7>;
+		};
+
 		serial0: serial at 1c020000 {
 			status = "disabled";
 			device_type = "serial";
-- 
1.9.1
