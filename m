From: mw@semihalf.com (Marcin Wojtas)
Date: Tue,  6 Oct 2015 03:22:40 +0200
Subject: [PATCH 6/8] ARM: mvebu: enable SDHCI card detection using DAT3 pin on
 A388-GP
In-Reply-To: <1444094562-31165-1-git-send-email-mw@semihalf.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
Message-ID: <1444094562-31165-7-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newest revisions of A388-GP (v1.5 and higher) support only
DAT3-based card detection, which is enabled by this commit. Hitherto
revisions, without such modification, will be impacted with a broken
card detection - in order to operate the cards have to be present
during kernel boot.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-388-gp.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 391dea9..4855963 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -213,8 +213,9 @@
 			sdhci at d8000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&sdhci_pins>;
-				cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;
 				no-1-8-v;
+				dat3-cd;
+				cd-inverted;
 				wp-inverted;
 				bus-width = <8>;
 				status = "okay";
-- 
1.8.3.1
