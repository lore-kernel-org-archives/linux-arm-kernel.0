From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Jun 2013 10:51:10 +0200
Subject: [PATCH 1/4] arm: mxs: Add #io-channel-cells property to lradc
In-Reply-To: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1372236673-20725-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding #io-channel-cells property to lradc allows us to use the lradc as an iio
provider.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 600f7cb..9a7feeb 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -829,6 +829,7 @@
 				interrupts = <10 14 15 16 17 18 19
 						20 21 22 23 24 25>;
 				status = "disabled";
+				#io-channel-cells = <1>;
 			};
 
 			spdif at 80054000 {
-- 
1.8.1.2
