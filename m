From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Jun 2013 17:11:24 +0100
Subject: [PATCH 06/10] regulator: ab8500: Ensure AB8500 external registers are
 probed first
In-Reply-To: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370621488-18130-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the order in which the AB8500 regulator drivers are
registered and subsequently probed. It saves a lot of -EPROBE_DEFEER
nonsense and bootlog noise, as some AB8500 core regulators depend on
the external ones for supply voltage.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 47a34ff..0f4964e 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
 obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
 obj-$(CONFIG_REGULATOR_AB3100) += ab3100.o
-obj-$(CONFIG_REGULATOR_AB8500)	+= ab8500.o ab8500-ext.o
+obj-$(CONFIG_REGULATOR_AB8500)	+= ab8500-ext.o ab8500.o
 obj-$(CONFIG_REGULATOR_AD5398) += ad5398.o
 obj-$(CONFIG_REGULATOR_ANATOP) += anatop-regulator.o
 obj-$(CONFIG_REGULATOR_ARIZONA) += arizona-micsupp.o arizona-ldo1.o
-- 
1.7.10.4
