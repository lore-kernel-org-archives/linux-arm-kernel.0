From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Sep 2011 11:01:40 -0700
Subject: [PATCH 2/2] ARM: debug: Move DEBUG_ICEDCC into the DEBUG_LL choice
In-Reply-To: <1316455300-5752-1-git-send-email-sboyd@codeaurora.org>
References: <20110916114140.GA31334@e102144-lin.cambridge.arm.com>
	<1316455300-5752-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1316455300-5752-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DEBUG_ICEDCC support is just another DEBUG_LL choice and
selecting it along with other DEBUG_LL options doesn't make
much sense. Put it into the DEBUG_LL choice to avoid confusion.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/Kconfig.debug |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index a37e646..9661c51 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -81,6 +81,18 @@ choice
 	prompt "Kernel low-level debugging port"
 	depends on DEBUG_LL
 
+	config DEBUG_ICEDCC
+		bool "Kernel low-level debugging via EmbeddedICE DCC channel"
+		depends on DEBUG_LL
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the EmbeddedICE macrocell's DCC channel using
+		  co-processor 14. This is known to work on the ARM9 style ICE
+		  channel and on the XScale with the PEEDI.
+
+		  It does include a timeout to ensure that the system does not
+		  totally freeze when there is nothing connected to read.
+
 	config DEBUG_DC21285_PORT
 		bool "Kernel low-level debugging messages via footbridge serial port"
 		depends on FOOTBRIDGE
@@ -114,18 +126,6 @@ config EARLY_PRINTK
 	  kernel low-level debugging functions. Add earlyprintk to your
 	  kernel parameters to enable this console.
 
-config DEBUG_ICEDCC
-	bool "Kernel low-level debugging via EmbeddedICE DCC channel"
-	depends on DEBUG_LL
-	help
-	  Say Y here if you want the debug print routines to direct their
-	  output to the EmbeddedICE macrocell's DCC channel using
-	  co-processor 14. This is known to work on the ARM9 style ICE
-	  channel and on the XScale with the PEEDI.
-
-	  It does include a timeout to ensure that the system does not
-	  totally freeze when there is nothing connected to read.
-
 config OC_ETM
 	bool "On-chip ETM and ETB"
 	select ARM_AMBA
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
