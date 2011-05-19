From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 19 May 2011 20:01:25 +0200
Subject: [PATCH] spi/pl022: use cpu_relax in the busy loop
Message-ID: <1305828085-25135-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This relaxes the cpu in the polling busy-wait loop.

Reported-by: Vitaly Wool <vitalywool@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/amba-pl022.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 18667de..8a2b88a 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1424,6 +1424,7 @@ static void do_polling_transfer(struct pl022 *pl022)
 				message->state = STATE_ERROR;
 				goto out;
 			}
+			cpu_relax();
 		}
 
 		/* Update total byte transferred */
-- 
1.7.3.2
