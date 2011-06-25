From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 25 Jun 2011 05:21:01 +0200
Subject: [PATCH] at91: fix at91_set_serial_console: use platform device id
Message-ID: <1308972061-32020-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91cap9_devices.c    |    2 +-
 arch/arm/mach-at91/at91rm9200_devices.c  |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9261_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9g45_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9rl_devices.c  |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index cd850ed..dba0d8d 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -1220,7 +1220,7 @@ void __init at91_set_serial_console(unsigned portnr)
 {
 	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
-		at91cap9_set_console_clock(portnr);
+		at91cap9_set_console_clock(at91_uarts[portnr]->id);
 	}
 }
 
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index a0ba475..7227755 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -1135,7 +1135,7 @@ void __init at91_set_serial_console(unsigned portnr)
 {
 	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
-		at91rm9200_set_console_clock(portnr);
+		at91rm9200_set_console_clock(at91_uarts[portnr]->id);
 	}
 }
 
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 1fdeb90..39f81f4 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -1173,7 +1173,7 @@ void __init at91_set_serial_console(unsigned portnr)
 {
 	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
-		at91sam9260_set_console_clock(portnr);
+		at91sam9260_set_console_clock(at91_uarts[portnr]->id);
 	}
 }
 
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 3eb4538..5004bf0 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -1013,7 +1013,7 @@ void __init at91_set_serial_console(unsigned portnr)
 {
 	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
-		at91sam9261_set_console_clock(portnr);
+		at91sam9261_set_console_clock(at91_uarts[portnr]->id);
 	}
 }
 
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index ffe081b..a050f41 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1395,7 +1395,7 @@ void __init at91_set_serial_console(unsigned portnr)
 {
 	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
-		at91sam9263_set_console_clock(portnr);
+		at91sam9263_set_console_clock(at91_uarts[portnr]->id);
 	}
 }
 
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 0567486..600bffb 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1550,7 +1550,7 @@ void __init at91_set_serial_console(unsigned portnr)
 {
 	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
-		at91sam9g45_set_console_clock(portnr);
+		at91sam9g45_set_console_clock(at91_uarts[portnr]->id);
 	}
 }
 
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index c296045..aacb19d 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -1168,7 +1168,7 @@ void __init at91_set_serial_console(unsigned portnr)
 {
 	if (portnr < ATMEL_MAX_UART) {
 		atmel_default_console_device = at91_uarts[portnr];
-		at91sam9rl_set_console_clock(portnr);
+		at91sam9rl_set_console_clock(at91_uarts[portnr]->id);
 	}
 }
 
-- 
1.7.4.1
