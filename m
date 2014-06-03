From: galak@codeaurora.org (Kumar Gala)
Date: Tue,  3 Jun 2014 15:13:22 -0500
Subject: [PATCH] tty: serial: msm: Fix section mismatch warning
Message-ID: <1401826402-1079-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: drivers/tty/built-in.o(.data+0x3544): Section mismatch in
reference from the variable msm_platform_driver to the function
.init.text:msm_serial_probe()
The variable msm_platform_driver references
the function __init msm_serial_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 778e376..24f3cdc 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -991,7 +991,7 @@ static const struct of_device_id msm_uartdm_table[] = {
 	{ }
 };
 
-static int __init msm_serial_probe(struct platform_device *pdev)
+static int msm_serial_probe(struct platform_device *pdev)
 {
 	struct msm_port *msm_port;
 	struct resource *resource;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
