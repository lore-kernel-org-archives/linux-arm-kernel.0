From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 24 Sep 2013 00:16:37 +0800
Subject: [PATCH 8/9] arm/dts: sirf: fix interrupt and dma prop of VIP for
 prima2 and atlas6
In-Reply-To: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
References: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1379952998-16393-9-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Renwei Wu <Renwei.Wu@csr.com>

the current dts is lacking interrupt and dma prop for video input
processor of prima2 and atlas6, this patch fixes it.

Signed-off-by: Renwei Wu <Renwei.Wu@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 2 ++
 arch/arm/boot/dts/prima2.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 6e6ddbc..a49032c 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -273,6 +273,8 @@
 				compatible = "sirf,prima2-vip";
 				reg = <0xb00C0000 0x10000>;
 				clocks = <&clks 31>;
+				interrupts = <14>;
+				sirf,vip-dma-rx-channel = <16>;
 			};
 
 			spi0: spi at b00d0000 {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 1484a45..2a54147 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -289,6 +289,8 @@
 				compatible = "sirf,prima2-vip";
 				reg = <0xb00C0000 0x10000>;
 				clocks = <&clks 31>;
+				interrupts = <14>;
+				sirf,vip-dma-rx-channel = <16>;
 			};
 
 			spi0: spi at b00d0000 {
-- 
1.8.2.3
