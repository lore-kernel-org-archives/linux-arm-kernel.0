From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 24 Sep 2013 00:16:31 +0800
Subject: [PATCH 2/9] arm/dts: sirf: add missed chhifbg node in prima2 and
 atlas6 dts
In-Reply-To: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
References: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1379952998-16393-3-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPHIF(Cell phone interface) is behind sys bridge, this patch adds the
missed node.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 5 +++++
 arch/arm/boot/dts/prima2.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 2c55b27..be188de 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -65,6 +65,11 @@
 				compatible = "sirf,prima2-rsc";
 				reg = <0x88020000 0x1000>;
 			};
+
+			cphifbg at 88030000 {
+				compatible = "sirf,prima2-cphifbg";
+				reg = <0x88030000 0x1000>;
+			};
 		};
 
 		mem-iobg {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 41b2cde..8c393bc 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -76,6 +76,11 @@
 				compatible = "sirf,prima2-rsc";
 				reg = <0x88020000 0x1000>;
 			};
+
+			cphifbg at 88030000 {
+				compatible = "sirf,prima2-cphifbg";
+				reg = <0x88030000 0x1000>;
+			};
 		};
 
 		mem-iobg {
-- 
1.8.2.3
