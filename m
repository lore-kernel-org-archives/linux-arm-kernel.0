From: jbe@pengutronix.de (Juergen Borleis)
Date: Fri, 17 Oct 2014 10:54:00 +0200
Subject: Samsung/S3C6410: CCF/clock for the built-in NAND controller fails
Message-ID: <201410171054.00845.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the S3C6410 SoC comes with a built-in NAND controller which is a shared 
component with (at least) the S3C2440 SoC. So the "drivers/mtd/nand/s3c2410.c" 
can also be used on the S3C6410. But currently it fails, because this driver 
tries to claim the clock "nand". Do we need an additional alias for that 
in "drivers/clk/samsung/clk-s3c64xx.c"?

Juergen
