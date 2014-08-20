From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 20 Aug 2014 10:43:02 +0200
Subject: [RFC PATCH 4/6] powerpc/85xx: Change vendor prefix for Intersil
 Corporation to isil
In-Reply-To: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1408524184-31928-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is a wild mixture of isl, isil, and intersil
compatibles in the kernel. At this point, changing the vendor
symbol to the most often used variant, which is equal to the
NASDAQ symbol, isil, should not hurt, since the isl1208 driver
doesn't care either way.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/powerpc/boot/dts/ppa8548.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/ppa8548.dts b/arch/powerpc/boot/dts/ppa8548.dts
index 27b0699..000262b 100644
--- a/arch/powerpc/boot/dts/ppa8548.dts
+++ b/arch/powerpc/boot/dts/ppa8548.dts
@@ -89,7 +89,7 @@
 &soc {
 	i2c at 3000 {
 		rtc at 6f {
-			compatible = "intersil,isl1208";
+			compatible = "isil,isl1208";
 			reg = <0x6f>;
 		};
 	};
-- 
2.1.0.rc1
