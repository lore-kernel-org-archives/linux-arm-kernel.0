From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 18 Jan 2017 09:46:30 -0800
Subject: [PATCH 09/33] Input: sun4i-lradc-keys - Drop unnecessary call to
 platform_set_drvdata and other changes
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Message-ID: <1484761614-12225-10-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no call to platform_get_drvdata() or dev_get_drvdata().
Drop the unnecessary call to platform_set_drvdata().
Other relevant changes:
  Simplify error return

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace 'if (e) return e; return 0;' with 'return e;'
- Drop platform_set_drvdata()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/keyboard/sun4i-lradc-keys.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index cc8f7ddcee53..c153d956778c 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -257,12 +257,7 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	error = input_register_device(lradc->input);
-	if (error)
-		return error;
-
-	platform_set_drvdata(pdev, lradc);
-	return 0;
+	return input_register_device(lradc->input);
 }
 
 static const struct of_device_id sun4i_lradc_of_match[] = {
-- 
2.7.4
