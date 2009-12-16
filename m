From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 16 Dec 2009 09:07:27 +0200
Subject: [PATCH 3/4] fec: add support for Freescale i.MX25 PDK (3DS)
In-Reply-To: <4B2882FC.6010006@snapgear.com>
References: <cover.1260785451.git.baruch@tkos.co.il>
	<fb518184b206ec2727deda111cc5364134ace69a.1260785451.git.baruch@tkos.co.il>
	<20091214103348.GV15126@pengutronix.de>
	<20091215083142.GB18290@jasper.tkos.co.il>
	<4B277878.1050804@snapgear.com> <20091215201109.GA2621@tarshish>
	<4B282644.8030104@snapgear.com>
	<20091216063402.GA13160@jasper.tkos.co.il>
	<4B2882FC.6010006@snapgear.com>
Message-ID: <20091216070726.GB13160@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2009 at 04:49:32PM +1000, Greg Ungerer wrote:
> 
> Hi Baruch,
> 
> Baruch Siach wrote:

[snip]

> >diff --git a/include/linux/fec.h b/include/linux/fec.h
> >new file mode 100644
> >index 0000000..5d3523d
> >--- /dev/null
> >+++ b/include/linux/fec.h
> >@@ -0,0 +1,21 @@
> >+/* include/linux/fec.h
> >+ *
> >+ * Copyright (c) 2009 Orex Computed Radiography
> >+ *   Baruch Siach <baruch@tkos.co.il>
> >+ *
> >+ * Header file for the FEC platform data
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify
> >+ * it under the terms of the GNU General Public License version 2 as
> >+ * published by the Free Software Foundation.
> >+ */
> >+#ifndef __LINUX_FEC_H__
> >+#define __LINUX_FEC_H__
> >+
> >+#include <linux/phy.h>
> >+
> >+struct fec_platform_data {
> >+	phy_interface_t phy;
> >+};
> >+
> >+#endif
> 
> Can't this go in drivers/net/fec.h with the other fec data structs?

No. The platform code (arch/arm/mach-mx25/mx25pdk.c in my case) must be able 
to use this struct to pass the necessary information to the driver. See for 
example include/linux/smsc911x.h, include/linux/smc91*.h, etc.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
