From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Mon, 25 Feb 2013 16:14:07 +0530
Subject: [PATCH 1/4] spi/davinci: fix module build error
In-Reply-To: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1361789050-637-2-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix below module build error:

  CC [M]  drivers/spi/spi-davinci.o
drivers/spi/spi-davinci.c:774:1: error: '__mod_of_device_table' aliased
to undefined symbol 'davini_spi_of_match'
drivers/spi/spi-davinci.c:774:1: error: '__mod_of_device_table' aliased
to undefined symbol 'davini_spi_of_match'
make[2]: *** [drivers/spi/spi-davinci.o] Error 1
make[1]: *** [drivers/spi] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 drivers/spi/spi-davinci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 50bd2cd..b30064b 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -771,7 +771,7 @@ static const struct of_device_id davinci_spi_of_match[] = {
 	},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, davini_spi_of_match);
+MODULE_DEVICE_TABLE(of, davinci_spi_of_match);
 
 /**
  * spi_davinci_get_pdata - Get platform data from DTS binding
-- 
1.7.4.1
