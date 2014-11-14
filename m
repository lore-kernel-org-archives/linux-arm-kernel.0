From: mw@semihalf.com (Marcin Wojtas)
Date: Fri, 14 Nov 2014 16:57:29 +0100
Subject: [PATCH v3 2/5] ARM: mvebu: enable no-1-8-v flag for Armada 385 DB
 SDHCI interface
In-Reply-To: <1415980652-7429-1-git-send-email-mw@semihalf.com>
References: <1415980652-7429-1-git-send-email-mw@semihalf.com>
Message-ID: <1415980652-7429-3-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x SoC's SDHCI interface is capable of using 1.8v voltage,
needed for driving "UHS-I" SD cards at their full speed. It is not, however,
possible on the DB board. Due to physical connectivity connector supply is tied
to 3v and any attempt of changing voltage in order to operate in the fastest UHS
modes fails.

This patch enables equivalent SDHCI quirk in order to adjust controller
operation to system capabilities.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-385-db.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index 1af886f..b125712 100644
--- a/arch/arm/boot/dts/armada-385-db.dts
+++ b/arch/arm/boot/dts/armada-385-db.dts
@@ -121,6 +121,7 @@
 				wp-inverted;
 				bus-width = <8>;
 				status = "okay";
+				no-1-8-v;
 			};
 
 			usb3 at f0000 {
-- 
1.8.3.1
