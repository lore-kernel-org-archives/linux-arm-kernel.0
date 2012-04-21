From: stigge@antcom.de (Roland Stigge)
Date: Sat, 21 Apr 2012 11:34:23 +0200
Subject: [PATCH v5 5/10] ARM: LPC32xx: Remove obsolete platform Kconfig
In-Reply-To: <1335000868-21974-1-git-send-email-stigge@antcom.de>
References: <1335000868-21974-1-git-send-email-stigge@antcom.de>
Message-ID: <1335000868-21974-6-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes two Kconfig options now unused (the network driver is
configured via DT now).

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

Applies to v3.4-rc3

--- linux-2.6.orig/arch/arm/mach-lpc32xx/Kconfig
+++ linux-2.6/arch/arm/mach-lpc32xx/Kconfig
@@ -29,30 +29,4 @@ config ARCH_LPC32XX_UART6_SELECT
 
 endmenu
 
-menu "LPC32XX chip components"
-
-config ARCH_LPC32XX_IRAM_FOR_NET
-	bool "Use IRAM for network buffers"
-	default y
-	help
-	  Say Y here to use the LPC internal fast IRAM (i.e. 256KB SRAM) as
-	  network buffer.  If the total combined required buffer sizes is
-	  larger than the size of IRAM, then SDRAM will be used instead.
-
-	  This can be enabled safely if the IRAM is not intended for other
-	  uses.
-
-config ARCH_LPC32XX_MII_SUPPORT
-	bool "Check to enable MII support or leave disabled for RMII support"
-	help
-	  Say Y here to enable MII support, or N for RMII support. Regardless of
-	  which support is selected, the ethernet interface driver needs to be
-	  selected in the device driver networking section.
-
-	  The PHY3250 reference board uses RMII, so users of this board should
-	  say N.
-
-endmenu
-
 endif
-
