From: joyce.ooi@intel.com (Ooi, Joyce)
Date: Tue, 24 Apr 2018 11:01:58 +0800
Subject: [PATCH] arm64: dts: stratix10: Change pad skew values for EMAC0 PHY
 driver
Message-ID: <1524538918-21141-1-git-send-email-joyce.ooi@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HPS EMAC0 drive strength is changed to 4mA because the initial 8mA
drive strength has caused CE test to fail. This requires changes on the
pad skew for EMAC0 PHY driver. Based on several measurements done, Tx
clock does not require the extra 0.96ns delay.

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 0007564..8785f78 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -79,7 +79,7 @@
 			rxd2-skew-ps = <420>; /* 0ps */
 			rxd3-skew-ps = <420>; /* 0ps */
 			txen-skew-ps = <0>; /* -420ps */
-			txc-skew-ps = <1860>; /* 960ps */
+			txc-skew-ps = <900>; /* 0ps */
 			rxdv-skew-ps = <420>; /* 0ps */
 			rxc-skew-ps = <1680>; /* 780ps */
 		};
-- 
1.7.1
