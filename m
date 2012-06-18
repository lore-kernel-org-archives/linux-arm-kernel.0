From: snijsure@grid-net.com (Subodh Nijsure)
Date: Mon, 18 Jun 2012 14:39:32 -0700
Subject: [PATCH] Fixes console on AUART issue for MX28 platform
Message-ID: <1340055572-555-1-git-send-email-snijsure@grid-net.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Subodh Nijsure <snijsure@grid-net.com>
---
 drivers/tty/serial/mxs-auart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ca3d25e..2ced332 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -761,7 +761,7 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, s);
 
-	auart_port[pdev->id] = s;
+	auart_port[s->port.line] = s;
 
 	mxs_auart_reset(&s->port);
 
-- 
1.7.5.4
