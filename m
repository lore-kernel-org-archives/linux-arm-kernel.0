From: avictor.za@gmail.com (Andrew Victor)
Date: Thu, 28 Apr 2011 22:34:32 +0200
Subject: [PATCH] at91: fix map_io init usage
In-Reply-To: <1304012240-13571-1-git-send-email-plagnioj@jcrosoft.com>
References: <1304012240-13571-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <BANLkTi=sEimYumftMwqL4zzRnrVeTSP=Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

1] In arch/arm/mach-at91/board-stamp9g20.c:

@@ -32,7 +32,7 @@
 #include "generic.h

-static void __init portuxg20_map_io(void)
+static void __init portuxg20_init_early(void)
 {
       stamp9g20_map_io();

that last "stamp9g20_map_io()" call should also be stamp9g20_init_early()


2] In board-eb01.c, references to map_io should be probably changed to
init_early.
It's ARM7, so there is no memory-mapping.

Otherwise, looks good.
Acked-by: Andrew Victor <linux@maxim.org.za>


Regards,
  Andrew Victor
