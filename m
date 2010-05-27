From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 08:33:18 +0200
Subject: [PATCH v2 6/8] serial/imx: drvdata is sport and not &sport->port
In-Reply-To: <1274942000-3580-5-git-send-email-eric@eukrea.com>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>
	<1274942000-3580-2-git-send-email-eric@eukrea.com>
	<1274942000-3580-3-git-send-email-eric@eukrea.com>
	<1274942000-3580-4-git-send-email-eric@eukrea.com>
	<1274942000-3580-5-git-send-email-eric@eukrea.com>
Message-ID: <1274942000-3580-6-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

even if that's the same pointer this is more readable like this

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/serial/imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
index 936f810..a0ebe91 100644
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -1311,7 +1311,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	ret = uart_add_one_port(&imx_reg, &sport->port);
 	if (ret)
 		goto deinit;
-	platform_set_drvdata(pdev, &sport->port);
+	platform_set_drvdata(pdev, sport);
 
 	return 0;
 deinit:
-- 
1.6.3.3
