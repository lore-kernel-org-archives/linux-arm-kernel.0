From: csmanjuvijay@gmail.com (csmanjuvijay at gmail.com)
Date: Wed,  7 Dec 2016 22:34:16 +0000
Subject: [PATCH v2 3/3] USB: OHCI: nxp: remove useless extern declaration
In-Reply-To: <1481150056-3623-1-git-send-email-csmanjuvijay@gmail.com>
References: <1480735523-23950-1-git-send-email-csmanjuvijay@gmail.com>
 <1481150056-3623-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1481150056-3623-4-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <csmanjuvijay@gmail.com>

Remove usb_disabled() extern declaration as it is already declared
as extern in include/linux/usb.h.

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-usb at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
changelog V1->V2:
patch discrition is update with proper message.

 drivers/usb/host/ohci-nxp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index b7d4756..1843f04 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -56,8 +56,6 @@ static struct hc_driver __read_mostly ohci_nxp_hc_driver;
 
 static struct i2c_client *isp1301_i2c_client;
 
-extern int usb_disabled(void);
-
 static struct clk *usb_host_clk;
 
 static void isp1301_configure_lpc32xx(void)
-- 
2.7.4
