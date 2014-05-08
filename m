From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 16:56:23 +0200
Subject: [PATCH 1/2] iio: always select ANON_INODES
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Message-ID: <1399560990-1402858-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without ANON_INODES, we get this build error:

drivers/built-in.o: In function `iio_event_getfd':
:(.text+0x14bf18): undefined reference to `anon_inode_getfd'

All other users explicitly select this symbol, so we should
do the same thing here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio at vger.kernel.org
---
 drivers/iio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 743485e..345395e 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig IIO
 	tristate "Industrial I/O support"
+	select ANON_INODES
 	help
 	  The industrial I/O subsystem provides a unified framework for
 	  drivers for many different types of embedded sensors using a
-- 
1.8.3.2
