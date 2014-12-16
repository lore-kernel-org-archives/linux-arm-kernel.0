From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 16 Dec 2014 01:22:55 +0100
Subject: [PATCHv1 2/7] rtc: isl12022: deprecate use of isl in compatible
 string for isil
In-Reply-To: <cover.1418688042.git.arno@natisbad.org>
References: <cover.1418688042.git.arno@natisbad.org>
Message-ID: <7405d4a47a33693811f90a31b35444896568ba02.1418688042.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


"isil" and "isl" prefixes are used at various locations inside the kernel
to reference Intersil corporation. This patch is part of a series fixing
those locations were "isl" is used in compatible strings to use the now
expected "isil" prefix instead (NASDAQ symbol for Intersil and most used
version). The old compatible string is kept for backward compatibility.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/rtc/rtc-isl12022.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index ee3ba7e6b45e..f9b082784b90 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -275,7 +275,8 @@ static int isl12022_probe(struct i2c_client *client,
 
 #ifdef CONFIG_OF
 static const struct of_device_id isl12022_dt_match[] = {
-	{ .compatible = "isl,isl12022" },
+	{ .compatible = "isl,isl12022" }, /* for backward compat., don't use */
+	{ .compatible = "isil,isl12022" },
 	{ },
 };
 #endif
-- 
2.1.1
