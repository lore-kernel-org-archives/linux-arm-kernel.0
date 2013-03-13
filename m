From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 13:05:33 +0800
Subject: [PATCH v3 02/11] clocksource: select USE_OF by default
In-Reply-To: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363151142-32162-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since clksrc_of driver is always used in DT mode, select CONFIG_USE_OF
by default. It could avoid build issue.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/clocksource/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4c04d19..167ed92 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -1,4 +1,5 @@
 config CLKSRC_OF
+	select USE_OF
 	bool
 
 config CLKSRC_I8253
-- 
1.7.10.4
