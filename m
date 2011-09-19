From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Sep 2011 11:01:39 -0700
Subject: [PATCH 1/2] ARM: debug: Add CLSP711X_UART1 config choice
In-Reply-To: <20110916114140.GA31334@e102144-lin.cambridge.arm.com>
References: <20110916114140.GA31334@e102144-lin.cambridge.arm.com>
Message-ID: <1316455300-5752-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM patch 7072/1 (debug: use kconfig choice for selecting
DEBUG_LL UART) only allowed CLSP711X_UART2 to be selected because
there is no NONE option in a choice menu. Add a UART1 choice so
that users can still choose UART1 explicitly.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

On 09/16/11 04:41, Will Deacon wrote:
> Ah yes. This will need to be added as part of the platform updates to go via
> Arnd. It should be easy enough just to have a DEBUG_CLPS711X_UART1 option,
> for example, and the platform code will fall back to the first UART.

I couldn't find these patches applied in Arnd's tree so I based it off of
Russell's for-next branch.

 arch/arm/Kconfig.debug |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 60d1846..a37e646 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -90,14 +90,19 @@ choice
 		  Saying N will cause the debug messages to appear on the first
 		  16550 serial port.
 
+	config DEBUG_CLPS711X_UART1
+		bool "Kernel low-level debugging messages via UART1"
+		depends on ARCH_CLPS711X
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the first serial port on these devices.
+
 	config DEBUG_CLPS711X_UART2
 		bool "Kernel low-level debugging messages via UART2"
 		depends on ARCH_CLPS711X
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on these devices.
-		  Saying N will cause the debug messages to appear on the first
-		  serial port.
 
 endchoice
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
