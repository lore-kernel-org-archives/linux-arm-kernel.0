From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  3 Nov 2011 23:10:42 +0800
Subject: [PATCH v2] atmel/spi: fix missing probe during the switch to
	module_platform_driver
In-Reply-To: <1320331706-4946-1-git-send-email-plagnioj@jcrosoft.com>
References: <1320331706-4946-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1320333042-24880-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in commit 940ab889

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
v2:

	remove local work

Best Regards,
J.
 drivers/spi/spi-atmel.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 79665e2..a691240 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1072,6 +1072,7 @@ static struct platform_driver atmel_spi_driver = {
 	},
 	.suspend	= atmel_spi_suspend,
 	.resume		= atmel_spi_resume,
+	.probe		= atmel_spi_probe,
 	.remove		= __exit_p(atmel_spi_remove),
 };
 module_platform_driver(atmel_spi_driver);
-- 
1.7.7
