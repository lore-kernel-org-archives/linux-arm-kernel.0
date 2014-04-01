From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 1 Apr 2014 21:17:03 +0800
Subject: [PATCH] Input: w90p910_ts - depend on ARCH_W90X900
In-Reply-To: <20140401142046.14d4bb8c@endymion.delvare>
References: <20140401142046.14d4bb8c@endymion.delvare>
Message-ID: <CAKT61h__8fuJDs94akU73grWns82+mk1vmSdQw5fwd1Cx-455g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---------- Forwarded message ----------
From: Jean Delvare <jdelvare@suse.de>
Date: 2014-04-01 20:20 GMT+08:00
Subject: [PATCH] Input: w90p910_ts - depend on ARCH_W90X900
To: linux-input at vger.kernel.org, linux-arm-kernel at lists.infradead.org
??? Wan ZongShun <mcuos.com@gmail.com>, Dmitry Torokhov
<dmitry.torokhov@gmail.com>


The w90p910_ts touchscreen driver is heavily architecture dependent,
so there is no point in letting it be built on other architectures
than it was written for.

All other W90P910/W90X900 drivers already have that dependency, so it
makes things more consistent and configuration easier.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc8.orig/drivers/input/touchscreen/Kconfig
2014-02-09 16:53:02.945634113 +0100
+++ linux-3.14-rc8/drivers/input/touchscreen/Kconfig    2014-04-01
14:10:08.936933702 +0200
@@ -867,7 +867,7 @@ config TOUCHSCREEN_TSC2007

 config TOUCHSCREEN_W90X900
        tristate "W90P910 touchscreen driver"
-       depends on HAVE_CLK
+       depends on ARCH_W90X900
        help
          Say Y here if you have a W90P910 based touchscreen.

Sure, your idea is reasonable.

Acked-by Wan Zongshun <mcuos.com@gmail.com>

--
Jean Delvare
SUSE L3 Support


-- 
Wan ZongShun.
www.mcuos.com
