From: tbm@cyrius.com (Martin Michlmayr)
Date: Thu, 3 Nov 2011 12:57:43 +0000
Subject: [PATCH] kirkwood: Recognize A1 revision of 6282 chip
Message-ID: <20111103125742.GA29555@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recognize the Kirkwood 6282 revision A1 chip since products using
this chip are shipping now, such as the QNAP TS-x19P II devices.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index f3248cf..b9632ee 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -430,6 +430,8 @@ static char * __init kirkwood_id(void)
 	} else if (dev == MV88F6282_DEV_ID) {
 		if (rev == MV88F6282_REV_A0)
 			return "MV88F6282-Rev-A0";
+		else if (rev == MV88F6282_REV_A1)
+			return "MV88F6282-Rev-A1";
 		else
 			return "MV88F6282-Rev-Unsupported";
 	} else {
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
index 010bdeb..fede3d5 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -135,4 +135,5 @@
 
 #define MV88F6282_DEV_ID	0x6282
 #define MV88F6282_REV_A0	0
+#define MV88F6282_REV_A1	1
 #endif

-- 
Martin Michlmayr
http://www.cyrius.com/
