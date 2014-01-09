From: 21cnbao@gmail.com (Barry Song)
Date: Thu,  9 Jan 2014 13:01:08 +0800
Subject: [PATCH 1/4] ARM: dts: sirf: add lost clocks for cphifbg
Message-ID: <1389243671-18099-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

This patch adds lost clocks property(index 42) for cphifbg node in prima2 and
atlas6 dtsi.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |    1 +
 arch/arm/boot/dts/prima2.dtsi |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 978bab4..f303a6c 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -69,6 +69,7 @@
 			cphifbg at 88030000 {
 				compatible = "sirf,prima2-cphifbg";
 				reg = <0x88030000 0x1000>;
+				clocks = <&clks 42>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index daee5894..de3cfa5 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -80,6 +80,7 @@
 			cphifbg at 88030000 {
 				compatible = "sirf,prima2-cphifbg";
 				reg = <0x88030000 0x1000>;
+				clocks = <&clks 42>;
 			};
 		};
 
-- 
1.7.5.4
