From: b44548@freescale.com (Chao Fu)
Date: Thu, 25 Sep 2014 18:24:24 +0800
Subject: [PATCH 2/3] arm:dts:vf-610:add vybrid DSPI TCF transfer support
In-Reply-To: <1411640665-20671-1-git-send-email-b44548@freescale.com>
References: <1411640665-20671-1-git-send-email-b44548@freescale.com>
Message-ID: <1411640665-20671-2-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

DSPI can transfer data in EOQ mode or TCF mode.
Add the bool value as the ajudgement of using which method
will be read from dtb.

Signed-off-by: Chao Fu      <b44548@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 4d2ec32..4339a19 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -174,6 +174,7 @@
 				clocks = <&clks VF610_CLK_DSPI0>;
 				clock-names = "dspi";
 				spi-num-chipselects = <5>;
+				tcfq-mode;
 				status = "disabled";
 			};
 
-- 
1.8.4
