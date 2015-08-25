From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 25 Aug 2015 14:34:28 +0530
Subject: [PATCH-v3 RESEND] mfd: 88pm80x: Add 88pm860 chip type support
Message-ID: <1440493468-5471-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add chip identification support for 88PM860 device
to the pm80x_chip_mapping table.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/88pm80x.c       | 2 ++
 include/linux/mfd/88pm80x.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mfd/88pm80x.c b/drivers/mfd/88pm80x.c
index 5e72f65..63445ea 100644
--- a/drivers/mfd/88pm80x.c
+++ b/drivers/mfd/88pm80x.c
@@ -33,6 +33,8 @@ static struct pm80x_chip_mapping chip_mapping[] = {
 	{0x3,	CHIP_PM800},
 	/* 88PM805 chip id number */
 	{0x0,	CHIP_PM805},
+	/* 88PM860 chip id number */
+	{0x4,	CHIP_PM860},
 };
 
 /*
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 8fcad63..d409ceb 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -21,6 +21,7 @@ enum {
 	CHIP_INVALID = 0,
 	CHIP_PM800,
 	CHIP_PM805,
+	CHIP_PM860,
 	CHIP_MAX,
 };
 
-- 
1.9.1
