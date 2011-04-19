From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Apr 2011 10:21:20 +0200
Subject: [PATCH] ARM: at91: AT91CAP9 has a macb device
Message-ID: <1303201280-25413-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit

	ee621dd (net: atmel_macb Kconfig: remove long dependency line)

replaced a list of several explicit machines in the dependencies of MACB by
a single symbol that is selected by the respective machines. ee621dd missed
to let ARCH_AT91CAP9 select HAVE_NET_MACB though which is fixed here.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-at91/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 1939023..2d299bf 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -83,6 +83,7 @@ config ARCH_AT91CAP9
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_FB_ATMEL
+	select HAVE_NET_MACB
 
 config ARCH_AT572D940HF
 	bool "AT572D940HF"
-- 
1.7.4.1
