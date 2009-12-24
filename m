From: eltshanli@gmail.com (Li Jie)
Date: Thu, 24 Dec 2009 10:47:16 +0800
Subject: [PATCH] ARM: NUC900: NUC900 Ethernet driver needs mii
Message-ID: <8fb2581d0912231847s34886d61s2d5cce0eaec5bf52@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wan:

nuc900 ethernet driver uses mii_xxx_xxx() serials api,
mii module should be selected.


Signed-off-by: lijie <eltshanli@gmail.com>
---
 drivers/net/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/arm/Kconfig b/drivers/net/arm/Kconfig
index c37ee9e..39e1c0d 100644
--- a/drivers/net/arm/Kconfig
+++ b/drivers/net/arm/Kconfig
@@ -68,6 +68,7 @@ config W90P910_ETH
 	tristate "Nuvoton w90p910 Ethernet support"
 	depends on ARM && ARCH_W90X900
 	select PHYLIB
+	select MII
 	help
 	  Say Y here if you want to use built-in Ethernet ports
 	  on w90p910 processor.
-- 
1.6.5.4
