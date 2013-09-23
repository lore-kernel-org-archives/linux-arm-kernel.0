From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 24 Sep 2013 00:16:38 +0800
Subject: [PATCH 9/9] arm/dts: sirf: fix the ranges of peri-iobrg of prima2
In-Reply-To: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
References: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1379952998-16393-10-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we lost an address range <0x56000000 0x56000000 0x1b00000> for peri-iobg
of prima2.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/prima2.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 2a54147..7cf78af 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -183,7 +183,8 @@
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0xb0000000 0xb0000000 0x180000>;
+			ranges = <0xb0000000 0xb0000000 0x180000>,
+			       <0x56000000 0x56000000 0x1b00000>;
 
 			timer at b0020000 {
 				compatible = "sirf,prima2-tick";
-- 
1.8.2.3
