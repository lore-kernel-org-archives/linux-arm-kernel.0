From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:16 +0000
Subject: [PATCH 03/19] mfd: ab2100-otp: Remove pointless 'out of memory' error
 message
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: Possible unnecessary 'out of memory' message
+       if (!otp) {
+               dev_err(&pdev->dev, "could not allocate AB3100 OTP device\n");

total: 0 errors, 1 warnings, 250 lines checked

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab3100-otp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ab3100-otp.c b/drivers/mfd/ab3100-otp.c
index f391c5fe..55b207a4 100644
--- a/drivers/mfd/ab3100-otp.c
+++ b/drivers/mfd/ab3100-otp.c
@@ -188,10 +188,9 @@ static int __init ab3100_otp_probe(struct platform_device *pdev)
 	int i;
 
 	otp = devm_kzalloc(&pdev->dev, sizeof(struct ab3100_otp), GFP_KERNEL);
-	if (!otp) {
-		dev_err(&pdev->dev, "could not allocate AB3100 OTP device\n");
+	if (!otp)
 		return -ENOMEM;
-	}
+
 	otp->dev = &pdev->dev;
 
 	/* Replace platform data coming in with a local struct */
-- 
1.9.1
