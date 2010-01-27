From: buserror@gmail.com (Michel Pollet)
Date: Wed, 27 Jan 2010 14:18:44 +0000
Subject: [PATCH 3/3] ARM: S3C: Kconfig option related to UART dev names
In-Reply-To: <1264601924-18480-2-git-send-email-buserror@gmail.com>
References: <1264601924-18480-1-git-send-email-buserror@gmail.com>
	<1264601924-18480-2-git-send-email-buserror@gmail.com>
Message-ID: <1264601924-18480-3-git-send-email-buserror@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C UART devices  are named s3c2410_serialX and it is
inconsistent with the kernel at boot time (console=ttySACx)
This patch allows the config file to override this and
use the standard name instead.

Signed-off-by: Michel Pollet <buserror@gmail.com>
---
 arch/arm/plat-s3c/Kconfig |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 9e9d028..158257a 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -113,6 +113,15 @@ config S3C_LOWLEVEL_UART_PORT
 	  this configuration should be between zero and two. The port
 	  must have been initialised by the boot-loader before use.
 
+config S3C_STD_UART_NAMES
+	bool "Name S3C UART device files as ttySACx"
+	default n
+	help
+	  The kernel and most other SoC use the ttySACx naming scheme
+	  for UART device file naming. The default for S3C is to use
+	  s3c2410_serialX, and it confuses a lot of distros; it is also
+	  inconsistent with the console= kernel parameter.
+
 # options for gpiolib support
 
 config S3C_GPIO_SPACE
-- 
1.6.6
