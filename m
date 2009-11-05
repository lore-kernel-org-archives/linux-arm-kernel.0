From: tbm@cyrius.com (Martin Michlmayr)
Date: Thu, 5 Nov 2009 18:09:01 +0000
Subject: [PATCH] Kirkwood: Add MPP36 for QNAP TS-11x/TS-21x
Message-ID: <20091105180901.GA10037@deprecation.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MPP36 is used on the QNAP TS-11x/TS-21x devices to indicate how
much RAM there is: it's high for 512 MB RAM (TS-x19) and low for
256 MB (TS-x10).  While this may not be very useful, let's add
it for completeness.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index ec1a64f..cb0f56d 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -152,6 +152,7 @@ static unsigned int qnap_ts219_mpp_config[] __initdata = {
 	MPP14_UART1_RXD,	/* PIC controller */
 	MPP15_GPIO,		/* USB Copy button */
 	MPP16_GPIO,		/* Reset button */
+	MPP36_GPIO,		/* RAM: 0: 256 MB, 1: 512 MB */
 	0
 };
 

-- 
Martin Michlmayr
http://www.cyrius.com/
