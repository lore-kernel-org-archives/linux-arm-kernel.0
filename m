From: mporter@linaro.org (Matt Porter)
Date: Mon,  3 Feb 2014 08:40:29 -0500
Subject: [PATCH v2 3/6] iio: enable selection and build of pulse drivers
In-Reply-To: <1391434832-23807-1-git-send-email-mporter@linaro.org>
References: <1391434832-23807-1-git-send-email-mporter@linaro.org>
Message-ID: <1391434832-23807-4-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the pulse driver subdirectory when configuring and building
IIO.

Signed-off-by: Matt Porter <mporter@linaro.org>
---
 drivers/iio/Kconfig  | 1 +
 drivers/iio/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 5dd0e12..286acc3 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -74,6 +74,7 @@ if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
 endif #IIO_TRIGGER
 source "drivers/iio/pressure/Kconfig"
+source "drivers/iio/pulse/Kconfig"
 source "drivers/iio/temperature/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 887d390..9a953c9 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -24,5 +24,6 @@ obj-y += light/
 obj-y += magnetometer/
 obj-y += orientation/
 obj-y += pressure/
+obj-y += pulse/
 obj-y += temperature/
 obj-y += trigger/
-- 
1.8.4
