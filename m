From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Tue,  5 Aug 2014 13:34:00 -0400
Subject: [PATCH 1/2] ARM: dts: vf610-twr: Fix pinctrl_esdhc1 pin definitions.
In-Reply-To: <1407260041-19234-1-git-send-email-bpringlemeir@nbsps.com>
References: <1407260041-19234-1-git-send-email-bpringlemeir@nbsps.com>
Message-ID: <1407260041-19234-2-git-send-email-bpringlemeir@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previous version had an extra 'fsl' which made the pins not match
any entry.  The console message,

 vf610-pinctrl 40048000.iomuxc: no fsl,pins property in node \
    /soc/aips-bus at 40000000/iomuxc at 40048000/vf610-twr/esdhc1grp

is displayed without the fix.  The prior version would generally
work as u-boot sets the pins properly for sdhc.  This change allows
Linux sdhc use even if u-boot is built without sdhc support.

Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 11d7334..b8a5e8c 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -168,7 +168,7 @@
 		};
 
 		pinctrl_esdhc1: esdhc1grp {
-			fsl,fsl,pins = <
+			fsl,pins = <
 				VF610_PAD_PTA24__ESDHC1_CLK	0x31ef
 				VF610_PAD_PTA25__ESDHC1_CMD	0x31ef
 				VF610_PAD_PTA26__ESDHC1_DAT0	0x31ef
-- 
1.8.0.2
