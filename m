From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Jan 2012 15:22:24 +0800
Subject: mc13xxx: add I2C support
In-Reply-To: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120119072222.GD2247@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, Jan 19, 2012 at 12:01:31PM +1100, Marc Reilly wrote:
> Hi,
> 
> This series (based on 3.2) adds I2C support for the mc13xxx family PMICs.
> The patches are similar, but not identical to my previous patches for this [1], the
> main difference being the way the config items are done in patch 2.
> 
The series looks nice.

> I don't have the hardware to retest on SPI hardware, I'd appreciate if someone could 
> double check it still works.
> 
I just gave it a spin on my imx51 babbage board where mc13892 is
connected on spi.  The spi access works fine as before, since the part
still gets recognized correctly.

BTW, I see the following compile error.

  CC      drivers/regulator/mc13892-regulator.o
In file included from include/linux/mfd/mc13892.h:12:0,
                 from drivers/regulator/mc13892-regulator.c:13:
include/linux/mfd/mc13xxx.h:87:15: error: field ?lock? has incomplete type

And I fixed it as below.

---8<----
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index c17fc60..4ca8439 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -10,6 +10,7 @@
 #define __LINUX_MFD_MC13XXX_H

 #include <linux/interrupt.h>
+#include <linux/mutex.h>

 struct mc13xxx;

---->8---

-- 
Regards,
Shawn
