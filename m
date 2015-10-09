From: mw@semihalf.com (Marcin Wojtas)
Date: Fri,  9 Oct 2015 03:03:53 +0200
Subject: [PATCH v2 3/5] ARM: mvebu: set SW polling as SDHCI card detection on
 A388-GP
In-Reply-To: <1444352635-21965-1-git-send-email-mw@semihalf.com>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
Message-ID: <1444352635-21965-4-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newest revisions of A388-GP (v1.5 and higher) support only
DAT3-based card detection. Revisions < v1.5 based on GPIO detection
via I2C expander, but this solution is supposed to be deprecated on
new boards. In order to satisfy all type of hardware this commit
changes card detection to use software polling mechanism.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-388-gp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 391dea9..403a86b 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -213,8 +213,8 @@
 			sdhci at d8000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&sdhci_pins>;
-				cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;
 				no-1-8-v;
+				broken-cd;
 				wp-inverted;
 				bus-width = <8>;
 				status = "okay";
-- 
1.8.3.1
