From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 6 Feb 2018 16:59:23 +0300
Subject: [PATCH 0/4] tree-wide: fix comparison to bitshift when dealing
 with a mask
In-Reply-To: <alpine.DEB.2.20.1802061439110.3306@hadrien>
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
 <20180206131044.oso33fvv553trrd7@mwanda>
 <alpine.DEB.2.20.1802061414340.3306@hadrien>
 <20180206132335.luut6em3kut7f7ej@mwanda>
 <alpine.DEB.2.20.1802061439110.3306@hadrien>
Message-ID: <20180206135923.3zthazmsapuzfxra@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That found 4 that I think Wolfram's grep missed.

 arch/um/drivers/vector_user.h             |    2 --
 drivers/gpu/drm/mxsfb/mxsfb_regs.h        |    2 --
 drivers/video/fbdev/mxsfb.c               |    2 --
 include/drm/drm_scdc_helper.h             |    3 ---

But it didn't find the two bugs that Geert found where the right side
wasn't a number literal.

drivers/net/can/m_can/m_can.c:#define RXFC_FWM_MASK     (0x7f < RXFC_FWM_SHIFT)
drivers/usb/gadget/udc/goku_udc.h:#define INT_EPnNAK(n) (0x00100 < (n))         /* 0 < n < 4 */

regards,
dan carpenter
