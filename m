From: lho@apm.com (Loc Ho)
Date: Mon, 31 Mar 2014 11:36:10 -0600
Subject: [PATCH v2 3/3] arm64: Add APM X-Gene SoC RTC DTS entry
In-Reply-To: <1396287370-1011-3-git-send-email-lho@apm.com>
References: <1396287370-1011-1-git-send-email-lho@apm.com>
 <1396287370-1011-2-git-send-email-lho@apm.com>
 <1396287370-1011-3-git-send-email-lho@apm.com>
Message-ID: <1396287370-1011-4-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds APM X-Gene SoC RTC DTS entry

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 93f4b2d..4917f3b 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -257,6 +257,19 @@
 				enable-offset = <0x0>;
 				enable-mask = <0x39>;
 			};
+
+			rtcclk: rtcclk at 17000000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x17000000 0x0 0x2000>;
+				reg-names = "csr-reg";
+				csr-offset = <0xc>;
+				csr-mask = <0x2>;
+				enable-offset = <0x10>;
+				enable-mask = <0x2>;
+				clock-output-names = "rtcclk";
+			};
 		};
 
 		serial0: serial at 1c020000 {
@@ -339,5 +352,13 @@
 			phys = <&phy3 0>;
 			phy-names = "sata-phy";
 		};
+
+		rtc: rtc at 10510000 {
+			compatible = "apm,xgene-rtc";
+			reg = <0x0 0x10510000 0x0 0x400>;
+			interrupts = <0x0 0x46 0x4>;
+			#clock-cells = <1>;
+			clocks = <&rtcclk 0>;
+		};
 	};
 };
-- 
1.5.5
