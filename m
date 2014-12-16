From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 16 Dec 2014 01:23:42 +0100
Subject: [PATCHv1 4/7] staging: iio: isl29028: deprecate use of isl in
 compatible string for isil
In-Reply-To: <cover.1418688042.git.arno@natisbad.org>
References: <cover.1418688042.git.arno@natisbad.org>
Message-ID: <d28a812f3a873654d573aed18bbcf9dc0c22c6fd.1418688042.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


"isil" and "isl" prefixes are used at various locations inside the kernel
to reference Intersil corporation. This patch is part of a series fixing
those locations were "isl" is used in compatible strings to use the now
expected "isil" prefix instead (NASDAQ symbol for Intersil and most used
version). The old compatible string is kept for backward compatibility.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/staging/iio/light/isl29028.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index e969107ddb47..6440e3b293ca 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -537,8 +537,8 @@ static const struct i2c_device_id isl29028_id[] = {
 MODULE_DEVICE_TABLE(i2c, isl29028_id);
 
 static const struct of_device_id isl29028_of_match[] = {
-	{ .compatible = "isl,isl29028", },
-	{ .compatible = "isil,isl29028", },/* deprecated, don't use */
+	{ .compatible = "isl,isl29028", }, /* for backward compat., don't use */
+	{ .compatible = "isil,isl29028", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, isl29028_of_match);
-- 
2.1.1
