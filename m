From: frieder.schrempf@kontron.de (Frieder Schrempf)
Date: Wed,  7 Nov 2018 15:43:25 +0100
Subject: [PATCH v4 08/10] ARM: dts: ls1021a: Remove fsl,
 qspi-has-second-chip as it is not used
In-Reply-To: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
Message-ID: <1541601809-16950-9-git-send-email-frieder.schrempf@kontron.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frieder Schrempf <frieder.schrempf@exceet.de>

After switching to the new FSL QSPI driver the property
'fsl,qspi-has-second-chip' is not needed anymore.

The driver now uses the 'reg' property to determine the bus and
the chipselect.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
index 6a83f30..d3a1a73 100644
--- a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
+++ b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
@@ -203,7 +203,6 @@
 };
 
 &qspi {
-	fsl,qspi-has-second-chip;
 	status = "okay";
 
 	flash: flash at 0 {
-- 
2.7.4
