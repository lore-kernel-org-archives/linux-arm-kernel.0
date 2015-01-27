From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jan 2015 22:50:07 -0600
Subject: [PATCH 1/3] tty/serial: of_serial: add DT alias ID handling
Message-ID: <1422334209-23125-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for alias parsing from the DT. This allows for consistent
tty numbering.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial at vger.kernel.org
---
 drivers/tty/serial/of_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 64f1bab..3194b42 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -128,6 +128,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (of_find_property(np, "no-loopback-test", NULL))
 		port->flags |= UPF_SKIP_TEST;
 
+	ret = of_alias_get_id(np, "serial");
+	if (ret >= 0)
+		port->line = ret;
+
 	port->dev = &ofdev->dev;
 
 	switch (type) {
-- 
2.1.0
