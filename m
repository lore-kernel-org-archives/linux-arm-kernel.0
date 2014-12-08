From: olof@lixom.net (Olof Johansson)
Date: Mon,  8 Dec 2014 13:54:04 -0800
Subject: [PATCH 1/2] clk: bcm: kona: don't return -EFOO as bool
Message-ID: <1418075645-14571-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Found with sparse:

drivers/clk/bcm/clk-kona.c:1255:16: warning: odd constant _Bool cast (ffffffffffffffea becomes 1)

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/clk/bcm/clk-kona.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 95af2e6..53fca77 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1252,7 +1252,7 @@ static bool __kona_clk_init(struct kona_clk *bcm_clk)
 	default:
 		BUG();
 	}
-	return -EINVAL;
+	return false;
 }
 
 /* Set a CCU and all its clocks into their desired initial state */
-- 
1.7.10.4
