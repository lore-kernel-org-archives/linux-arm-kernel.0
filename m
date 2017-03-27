From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Mon, 27 Mar 2017 15:49:42 +0800
Subject: [v3, 7/7] arm64: dts: ls1046ardb: add MMC HS200/UHS-1 modes support
In-Reply-To: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1490600982-5410-8-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HS200/UHS-1 properties in eSDHC node to support these
speed modes in driver.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None
Changes for v3:
	- None
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index d1ccc00..08528c2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -64,6 +64,14 @@
 	};
 };
 
+&esdhc {
+	mmc-hs200-1_8v;
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+};
+
 &duart0 {
 	status = "okay";
 };
-- 
2.1.0.27.g96db324
