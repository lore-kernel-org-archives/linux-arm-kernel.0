From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 16 Dec 2014 01:23:18 +0100
Subject: [PATCHv1 3/7] rtc: isl12057: deprecate use of isl in compatible
 string for isil
In-Reply-To: <cover.1418688042.git.arno@natisbad.org>
References: <cover.1418688042.git.arno@natisbad.org>
Message-ID: <4541d90a3f81ad51fdc42b13f6e9b1611ef73206.1418688042.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


"isil" and "isl" prefixes are used at various locations inside the kernel
to reference Intersil corporation. This patch is part of a series fixing
those locations were "isl" is used in compatible strings to use the now
expected "isil" prefix instead (NASDAQ symbol for Intersil and most used
version). The old compatible string is kept for backward compatibility.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/rtc/rtc-isl12057.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index bd76c5e35fa5..cd6d8cc8c2c9 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -644,7 +644,8 @@ static SIMPLE_DEV_PM_OPS(isl12057_rtc_pm_ops, isl12057_rtc_suspend,
 
 #ifdef CONFIG_OF
 static const struct of_device_id isl12057_dt_match[] = {
-	{ .compatible = "isl,isl12057" },
+	{ .compatible = "isl,isl12057" }, /* for backward compat., don't use */
+	{ .compatible = "isil,isl12057" },
 	{ },
 };
 #endif
-- 
2.1.1
