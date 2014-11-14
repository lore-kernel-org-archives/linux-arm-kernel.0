From: mw@semihalf.com (Marcin Wojtas)
Date: Fri, 14 Nov 2014 16:57:30 +0100
Subject: [PATCH v3 3/5] ARM: mvebu: remove clock-frequency from Armada 38x
 SDHCI Device Tree node
In-Reply-To: <1415980652-7429-1-git-send-email-mw@semihalf.com>
References: <1415980652-7429-1-git-send-email-mw@semihalf.com>
Message-ID: <1415980652-7429-4-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For proper operation of Armada 38x SDHCI controller proper 'clocks' property
is sufficient. Therefore it is not useful to keep an additional
'clock-frequency' property in SDHCI controller node of board-level Device Tree
file for Armada 385 DB.

This commit gets rid of useless 'clock-frequency' property.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-385-db.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index b125712..2aaa9d2 100644
--- a/arch/arm/boot/dts/armada-385-db.dts
+++ b/arch/arm/boot/dts/armada-385-db.dts
@@ -116,7 +116,6 @@
 			};
 
 			sdhci at d8000 {
-				clock-frequency = <200000000>;
 				broken-cd;
 				wp-inverted;
 				bus-width = <8>;
-- 
1.8.3.1
