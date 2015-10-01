From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu,  1 Oct 2015 16:13:05 +0300
Subject: [PATCH 1/1] ARM: davinci: re-use %*ph specifier
Message-ID: <1443705185-85280-1-git-send-email-andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

%*ph specifier allows to dump data in hex format using the poiter to a buffer.
This is suitable to use here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 1a0898c..bbdd2d6 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -546,9 +546,7 @@ static int dm6444evm_msp430_get_pins(void)
 	if (status < 0)
 		return status;
 
-	dev_dbg(&dm6446evm_msp->dev,
-		"PINS: %02x %02x %02x %02x\n",
-		buf[0], buf[1], buf[2], buf[3]);
+	dev_dbg(&dm6446evm_msp->dev, "PINS: %4ph\n", buf);
 
 	return (buf[3] << 8) | buf[2];
 }
-- 
2.5.1
