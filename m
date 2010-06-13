From: tbm@cyrius.com (Martin Michlmayr)
Date: Sun, 13 Jun 2010 19:37:18 +0100
Subject: [PATCH] Kirkwood: Add MPP44 (board ID) on TS-219
Message-ID: <20100613183718.GA6929@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MPP44 can be used to differentiate between one-bay (TS-11x) and
two-bay (TS-21x) devices.

According to an engineer from QNAP, the setting of MPP44 depends
on the firmware rather than hardware.  Presumably, this means
that you could fake the MPP44 value by changing the boot loader.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index 2830f0f..40ed723 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -83,6 +83,7 @@ static unsigned int qnap_ts219_mpp_config[] __initdata = {
 	MPP15_GPIO,		/* USB Copy button */
 	MPP16_GPIO,		/* Reset button */
 	MPP36_GPIO,		/* RAM: 0: 256 MB, 1: 512 MB */
+	MPP44_GPIO,		/* Board ID: 0: TS-11x, 1: TS-21x */
 	0
 };
 

-- 
Martin Michlmayr
http://www.cyrius.com/
