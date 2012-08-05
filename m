From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 5 Aug 2012 23:05:20 +0800
Subject: [PATCH v2 3/4] regulator: add a new API regulator_set_voltage_tol()
In-Reply-To: <1344179121-17738-1-git-send-email-shawn.guo@linaro.org>
References: <1344179121-17738-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344179121-17738-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some use cases where a voltage range could be reasonably
specified by a target voltage and tolerance.  Add a new API
regulator_set_voltage_tol() wrapping regulator_set_voltage() call
to ease the users.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 include/linux/regulator/consumer.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index da339fd..2160352 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -352,4 +352,11 @@ static inline void regulator_set_drvdata(struct regulator *regulator,
 
 #endif
 
+static inline int regulator_set_voltage_tol(struct regulator *regulator,
+					    int new_uV, int tol_uV)
+{
+	return regulator_set_voltage(regulator,
+				     new_uV - tol_uV, new_uV + tol_uV);
+}
+
 #endif
-- 
1.7.5.4
