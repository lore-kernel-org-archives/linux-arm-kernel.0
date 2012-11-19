From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 20 Nov 2012 06:44:45 +1300
Subject: [PATCH v3 1/2] Fix build error in pwm-vt8500.c
In-Reply-To: <1353347086-4572-1-git-send-email-linux@prisktech.co.nz>
References: <1353347086-4572-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1353347086-4572-2-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A missing '{' causes a build error in pwm-vt8500.c

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/pwm/pwm-vt8500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 970b0c6..806f72c 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -100,7 +100,7 @@ static int vt8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
 
 	err = clk_enable(vt8500->clk);
-	if (err < 0)
+	if (err < 0) {
 		dev_err(chip->dev, "failed to enable clock\n");
 		return err;
 	};
-- 
1.7.9.5
