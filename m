From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Feb 2014 09:34:28 +0900
Subject: [PATCH V2 2/2] ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
In-Reply-To: <1392633882-12142-2-git-send-email-wsa@the-dreams.de>
References: <1392633882-12142-1-git-send-email-wsa@the-dreams.de>
 <1392633882-12142-2-git-send-email-wsa@the-dreams.de>
Message-ID: <20140218003428.GG4776@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 11:44:42AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>

Thanks, I have queued up the following after resolving a minor conflict.


From: Wolfram Sang <wsa@sang-engineering.com>

ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: resolved conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index f67d2d0..bf6ba0c 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -108,10 +108,29 @@
 	clock-frequency = <20000000>;
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom at 50 {
+		compatible = "renesas,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
 &pfc {
 	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
 
+	i2c2_pins: i2c {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
+
 	du_pins: du {
 		renesas,groups = "du_rgb666", "du_sync", "du_clk_out_0";
 		renesas,function = "du";
-- 
1.8.5.2
