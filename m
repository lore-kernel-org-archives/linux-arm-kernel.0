From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  8 Aug 2013 15:30:29 +0200
Subject: [PATCH 3/3] crypto: dcp: rename 'compatible' property to 'fsl,dcp'
In-Reply-To: <1375968629-10091-1-git-send-email-LW@KARO-electronics.de>
References: <1375968629-10091-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375968629-10091-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leave the old 'fsl-dcp' value in place with an appropriate comment
until external users have updated their DTBs.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28.dtsi |    2 +-
 drivers/crypto/dcp.c         |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index ea99d09..0584935 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -794,7 +794,7 @@
 			};
 
 			dcp: dcp at 80028000 {
-				compatible = "fsl-dcp";
+				compatible = "fsl,dcp";
 				reg = <0x80028000 0x2000>;
 				interrupts = <52 53 54>;
 				status = "disabled";
diff --git a/drivers/crypto/dcp.c b/drivers/crypto/dcp.c
index 6a2495e..72196c0 100644
--- a/drivers/crypto/dcp.c
+++ b/drivers/crypto/dcp.c
@@ -889,6 +889,8 @@ static int dcp_remove(struct platform_device *pdev)
 }
 
 static struct of_device_id fs_dcp_of_match[] = {
+	{ .compatible = "fsl,dcp", },
+	/* To be removed when the DT blobs referencing this have been updated */
 	{ .compatible = "fsl-dcp", },
 	{}
 };
-- 
1.7.2.5
