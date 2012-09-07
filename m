From: balbi@ti.com (Felipe Balbi)
Date: Fri,  7 Sep 2012 08:21:52 +0300
Subject: [PATCH] serial: omap: fix compile breakage
Message-ID: <1346995312-2872-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when rebasing patches on top of Greg's tty-next,
it looks like automerge broke a few things which
I didn't catch (for whatever reason I didn't
have OMAP Serial enabled on .config) so I ended
up breaking the build on Greg's tty-next branch.

Fix the breakage by re-adding the three missing
members on struct uart_omap_port.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index e31d291..8e4a7aa 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -123,6 +123,10 @@ struct uart_omap_port {
 	u8			wakeups_enabled;
 	unsigned int		irq_pending:1;
 
+	int			DTR_gpio;
+	int			DTR_inverted;
+	int			DTR_active;
+
 	struct pm_qos_request	pm_qos_request;
 	u32			latency;
 	u32			calc_latency;
-- 
1.7.12.rc3
