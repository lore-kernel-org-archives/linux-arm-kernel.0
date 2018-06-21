From: nick@shmanahar.org (Nick Dyer)
Date: Thu, 21 Jun 2018 19:10:00 +0100
Subject: [PATCH v5] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
In-Reply-To: <CAFXsbZr-HJE54c0BC5=d1tStByA5ytGhSSZMirNKE03JzGCDXQ@mail.gmail.com>
References: <CAFXsbZr-HJE54c0BC5=d1tStByA5ytGhSSZMirNKE03JzGCDXQ@mail.gmail.com>
Message-ID: <20180621181000.12687-1-nick@shmanahar.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl settings were incorrect for the touchscreen interrupt line, causing
an interrupt storm. This change has been tested with both the atmel_mxt_ts and
RMI4 drivers on the RDU1 units.

The value 0x4 comes from the value of register IOMUXC_SW_PAD_CTL_PAD_CSI1_D8
from the old vendor kernel.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
Fixes: ceef0396f367 ("ARM: dts: imx: add ZII RDU1 board")
Cc: <stable@vger.kernel.org> # 4.15+
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Chris Healy <cphealy@gmail.com>
---
Changes in v5:
- Add tested by Chris Healy
Changes in v4:
- Add reviewed by Fabio
Changes in v3:
- Update commit message to add source of 0x4 value, fixes tag and CC stable
Changes in v2:
- Use hex, only alter IRQ line config

 arch/arm/boot/dts/imx51-zii-rdu1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index df9eca94d812..8a878687197b 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -770,7 +770,7 @@
 
 	pinctrl_ts: tsgrp {
 		fsl,pins = <
-			MX51_PAD_CSI1_D8__GPIO3_12		0x85
+			MX51_PAD_CSI1_D8__GPIO3_12		0x04
 			MX51_PAD_CSI1_D9__GPIO3_13		0x85
 		>;
 	};
-- 
2.17.1
