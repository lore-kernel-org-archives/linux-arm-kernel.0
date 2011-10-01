From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:38 +0200
Subject: [PATCH 06/26] ARM: pxa: add missing header inclusions
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These resulted in build breakage in some configurations:

arch/arm/mach-pxa/irq.c:132:39: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'icip_handle_irq'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/irq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index b09e848..848e96d 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/syscore_ops.h>
+#include <linux/ftrace.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 
-- 
1.7.5.4
