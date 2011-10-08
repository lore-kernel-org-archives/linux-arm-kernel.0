From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2011 17:16:26 +0200
Subject: [PATCH 2/3] ARM: imx: add missing include of linux/ftrace.h
In-Reply-To: <109850802.HMOqKGRdrl@wuerfel>
References: <20111004092015.GM31404@pengutronix.de>
	<20111008101322.GH31404@pengutronix.de>
	<109850802.HMOqKGRdrl@wuerfel>
Message-ID: <1928841.IC5oQhqc6l@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the __exception_irq_entry symbol requires including
this header file:

arch/arm/plat-mxc/avic.c:154:39: error: expected '=', ',', ';', 'asm'
		or '__attribute__' before 'avic_handle_irq'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-mxc/avic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 8875fb4..9bab263 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/ftrace.h>
 #include <mach/common.h>
 #include <asm/mach/irq.h>
 #include <mach/hardware.h>
-- 
1.7.5.4
