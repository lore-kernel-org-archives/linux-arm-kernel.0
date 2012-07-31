From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:29:07 +0800
Subject: [PATCH 7/8] arm: pxa: fix device id for pwm
In-Reply-To: <1343716148-3899-1-git-send-email-xiechao.mail@gmail.com>
References: <1343716148-3899-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1343716148-3899-7-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

pxa910 has same pwm as pxa168. pxa910-pwm is not needed.
pxa168-pwm does not have depended secondary pwm.

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/plat-pxa/pwm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-pxa/pwm.c b/arch/arm/plat-pxa/pwm.c
index ef32686..45f039e 100644
--- a/arch/arm/plat-pxa/pwm.c
+++ b/arch/arm/plat-pxa/pwm.c
@@ -30,7 +30,6 @@ static const struct platform_device_id pwm_id_table[] = {
 	{ "pxa25x-pwm", 0 },
 	{ "pxa27x-pwm", 0 | HAS_SECONDARY_PWM },
 	{ "pxa168-pwm", 1 },
-	{ "pxa910-pwm", 1 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, pwm_id_table);
-- 
1.7.0.4
