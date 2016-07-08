From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  8 Jul 2016 17:00:40 +0800
Subject: [PATCH v3 2/3] tty: amba-pl011: add .get_fifosize for ZTE device
In-Reply-To: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1467968441-4056-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ZTE PL011 device has a fixed FIFO size 16.  Let's add a .get_fifosize
hook for it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e09354e6bcb7..8b7fb3689ee7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -204,6 +204,11 @@ static const u16 pl011_zte_offsets[REG_ARRAY_SIZE] = {
 	[REG_DMACR] = ZX_UART011_DMACR,
 };
 
+static unsigned int get_fifosize_zte(struct amba_device *dev)
+{
+	return 16;
+}
+
 static struct vendor_data vendor_zte __maybe_unused = {
 	.reg_offset		= pl011_zte_offsets,
 	.access_32b		= true,
@@ -212,7 +217,7 @@ static struct vendor_data vendor_zte __maybe_unused = {
 	.fr_dsr			= ZX_UART01x_FR_DSR,
 	.fr_cts			= ZX_UART01x_FR_CTS,
 	.fr_ri			= ZX_UART011_FR_RI,
-	.get_fifosize		= get_fifosize_arm,
+	.get_fifosize		= get_fifosize_zte,
 };
 
 /* Deals with DMA transactions */
-- 
1.9.1
