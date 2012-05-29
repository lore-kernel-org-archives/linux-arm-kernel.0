From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 29 May 2012 15:30:18 -0700
Subject: [PATCH] staging: comedi: Make COMEDI_FC a hidden Kconfig option
Message-ID: <201205291530.19371.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The COMEDI_FC Kconfig option is selected by the relevant drivers
when needed. Since it only contains shared functions, selecting
it manually serves no purpose. Just make it a hidden selection.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: Mori Hess <fmhess@users.sourceforge.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---

diff --git a/drivers/staging/comedi/Kconfig b/drivers/staging/comedi/Kconfig
index 3bbe3fd..54e32da 100644
--- a/drivers/staging/comedi/Kconfig
+++ b/drivers/staging/comedi/Kconfig
@@ -1305,15 +1305,8 @@ config COMEDI_8255
 	  called 8255.
 
 config COMEDI_FC
-	tristate "Comedi shared functions for low-level driver support"
+	tristate
 	depends on COMEDI
-	---help---
-	  Enable support for shared functions for low-level drivers.
-	  This module is not used directly by end-users. Rather, it
-	  is used by many other comedi drivers.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called comedi_fc.
 
 config COMEDI_AMPLC_DIO200
 	tristate
